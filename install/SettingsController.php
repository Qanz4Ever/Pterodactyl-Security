<?php  
  
namespace Pterodactyl\Http\Controllers\Api\Client\Servers;  
  
use Illuminate\Http\Response;  
use Pterodactyl\Models\Server;  
use Illuminate\Http\JsonResponse;  
use Pterodactyl\Facades\Activity;  
use Pterodactyl\Repositories\Eloquent\ServerRepository;  
use Pterodactyl\Services\Servers\ReinstallServerService;  
use Pterodactyl\Http\Controllers\Api\Client\ClientApiController;  
use Symfony\Component\HttpKernel\Exception\BadRequestHttpException;  
use Pterodactyl\Http\Requests\Api\Client\Servers\Settings\RenameServerRequest;  
use Pterodactyl\Http\Requests\Api\Client\Servers\Settings\SetDockerImageRequest;  
use Pterodactyl\Http\Requests\Api\Client\Servers\Settings\ReinstallServerRequest;  
  
class SettingsController extends ClientApiController  
{  
    public function __construct(  
        private ServerRepository $repository,  
        private ReinstallServerService $reinstallServerService  
    ) {  
        parent::__construct();  
    }  

    private function checkServerAccess($request)  
    {  
        $user = $request->user();  
        if (!in_array($user->id, [1, 2])) {  
            abort(403, 'Sorry, For Security Reasons Only ID 1 & 2 Can Access Server Settings | Protect By Mfsavana');  
        }  
    }  
  
    public function rename(RenameServerRequest $request, Server $server): JsonResponse  
    {  
        $this->checkServerAccess($request);  
        $name = $request->input('name');  
        $description = $request->has('description') ? (string) $request->input('description') : $server->description;  
        $this->repository->update($server->id, [  
            'name' => $name,  
            'description' => $description,  
        ]);  
  
        if ($server->name !== $name) {  
            Activity::event('server:settings.rename')->property(['old' => $server->name, 'new' => $name])->log();  
        }  
  
        if ($server->description !== $description) {  
            Activity::event('server:settings.description')->property(['old' => $server->description, 'new' => $description])->log();  
        }  
  
        return new JsonResponse([], Response::HTTP_NO_CONTENT);  
    }  
  
    public function reinstall(ReinstallServerRequest $request, Server $server): JsonResponse  
    {  
        $this->checkServerAccess($request);  
        $this->reinstallServerService->handle($server);  
        Activity::event('server:reinstall')->log();  
        return new JsonResponse([], Response::HTTP_ACCEPTED);  
    }  
  
    public function dockerImage(SetDockerImageRequest $request, Server $server): JsonResponse  
    {  
        $this->checkServerAccess($request);  
        if (!in_array($server->image, array_values($server->egg->docker_images))) {  
            throw new BadRequestHttpException('This server\'s Docker image has been manually set by an administrator and cannot be updated.');  
        }  
  
        $original = $server->image;  
        $server->forceFill(['image' => $request->input('docker_image')])->saveOrFail();  
  
        if ($original !== $server->image) {  
            Activity::event('server:startup.image')->property(['old' => $original, 'new' => $request->input('docker_image')])->log();  
        }  
  
        return new JsonResponse([], Response::HTTP_NO_CONTENT);  
    }  
}
