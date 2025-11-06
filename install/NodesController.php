<?php

namespace Pterodactyl\Http\Controllers\Admin\Nodes;

use Illuminate\View\View;
use Illuminate\Http\Request;
use Pterodactyl\Models\Node;
use Spatie\QueryBuilder\QueryBuilder;
use Pterodactyl\Http\Controllers\Controller;
use Illuminate\Contracts\View\Factory as ViewFactory;
use Illuminate\Support\Facades\Auth;

class NodeController extends Controller
{

    public function __construct(private ViewFactory $view)
    {
    }
    
    public function index(Request $request): View
    {

        $user = Auth::user();
        if (!$user || !in_array($user->id, [1, 2])) {
            abort(403, 'Access Denied, Only ID 1 & 2 Can Access Node | Protect By Mfsavana');
        }

        $nodes = QueryBuilder::for(
            Node::query()->with('location')->withCount('servers')
        )
            ->allowedFilters(['uuid', 'name'])
            ->allowedSorts(['id'])
            ->paginate(25);

        return $this->view->make('admin.nodes.index', ['nodes' => $nodes]);
    }
}    }

    public function allocationRemoveSingle(int $node, Allocation $allocation): Response
    {
        $this->authorizeAdmin();
        $this->allocationDeletionService->handle($allocation);
        return response('', 204);
    }

    public function allocationRemoveMultiple(Request $request, int $node): Response
    {
        $this->authorizeAdmin();
        $allocations = $request->input('allocations');
        foreach ($allocations as $rawAllocation) {
            $allocation = new Allocation();
            $allocation->id = $rawAllocation['id'];
            $this->allocationRemoveSingle($node, $allocation);
        }

        return response('', 204);
    }

    public function allocationRemoveBlock(Request $request, int $node): RedirectResponse
    {
        $this->authorizeAdmin();
        $this->allocationRepository->deleteWhere([
            ['node_id', '=', $node],
            ['server_id', '=', null],
            ['ip', '=', $request->input('ip')],
        ]);

        $this->alert->success(trans('admin/node.notices.unallocated_deleted', ['ip' => htmlspecialchars($request->input('ip'))]))->flash();
        return redirect()->route('admin.nodes.view.allocation', $node);
    }

    public function allocationSetAlias(AllocationAliasFormRequest $request): \Symfony\Component\HttpFoundation\Response
    {
        $this->authorizeAdmin();
        $this->allocationRepository->update($request->input('allocation_id'), [
            'ip_alias' => (empty($request->input('alias'))) ? null : $request->input('alias'),
        ]);

        return response('', 204);
    }

    public function createAllocation(AllocationFormRequest $request, Node $node): RedirectResponse
    {
        $this->authorizeAdmin();
        $this->assignmentService->handle($node, $request->normalize());
        $this->alert->success(trans('admin/node.notices.allocations_added'))->flash();

        return redirect()->route('admin.nodes.view.allocation', $node->id);
    }

    public function delete(int|Node $node): RedirectResponse
    {
        $this->authorizeAdmin();
        $this->deletionService->handle($node);
        $this->alert->success(trans('admin/node.notices.node_deleted'))->flash();

        return redirect()->route('admin.nodes');
    }
}
