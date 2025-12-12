#!/bin/bash

CLEAR="\e[0m"
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
CYAN="\e[36m"

marker="Protect By Mfsavana"

install_patch() {
    name="$1"
    file="$2"
    url="$3"

    if [ -f "$file" ] && grep -Fq -- "$marker" "$file"; then
        echo "$name Sudah Pernah Di Install, Melewati Instalasi..."
        sleep 1
        return
    fi

    echo "Menginstall $name"
    mkdir -p "$(dirname "$file")"
    if [ -f "$file" ]; then
        cp "$file" "$file.bak"
    fi

    curl -fsSL "$url" -o "$file" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Gagal mengunduh file patch: $name"
        return
    fi

    sleep 1
    echo "$name Berhasil Di Install."
}

install_all() {
    mode="$1"

    case $mode in
        ID-1)
            bash "$0" 1 ID-1
            bash "$0" 2 ID-1
            bash "$0" 3 ID-1
            bash "$0" 4 ID-1
            bash "$0" 5 ID-1
            bash "$0" 6 ID-1
            bash "$0" 7 ID-1
            bash "$0" 8 ID-1
            bash "$0" 9 ID-1
            bash "$0" 10 ID-1
            ;;
        ID-1,2)
            bash "$0" 1 ID-1,2
            bash "$0" 2 ID-1,2
            bash "$0" 3 ID-1,2
            bash "$0" 4 ID-1,2
            bash "$0" 5 ID-1,2
            bash "$0" 6 ID-1,2
            bash "$0" 7 ID-1,2
            bash "$0" 8 ID-1,2
            bash "$0" 9 ID-1,2
            bash "$0" 10 ID-1,2
            ;;
        ID-1,2,3)
            bash "$0" 1 ID-1,2,3
            bash "$0" 2 ID-1,2,3
            bash "$0" 3 ID-1,2,3
            bash "$0" 4 ID-1,2,3
            bash "$0" 5 ID-1,2,3
            bash "$0" 6 ID-1,2,3
            bash "$0" 7 ID-1,2,3
            bash "$0" 8 ID-1,2,3
            bash "$0" 9 ID-1,2,3
            bash "$0" 10 ID-1,2,3
            ;;
    esac

    echo "❖────────────────────❖"
    echo "Semua Instalasi Telah Di Selesaikan"
    echo "Terima Kasih Sudah Menggunakan Script MFSAVANA SECURITY INSTALLER"
    echo "❖────────────────────❖"
}

case "$1" in
    all)
        install_all "$2"
        exit
        ;;

    1)
        file="/var/www/pterodactyl/app/Http/Controllers/Api/Client/Servers/FileController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/FileController.php"
        install_patch "Anti Akses File Server Selain Pemilik" "$file" "$url"
        ;;

    2)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/LocationController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/LocationController.php"
        install_patch "Anti Akses Menu Location Panel" "$file" "$url"
        ;;

    3)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nodes/NodeController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/NodeController.php"
        install_patch "Anti Akses Menu Nodes Panel" "$file" "$url"
        ;;

    4)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Settings/IndexController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/IndexController.php"
        install_patch "Anti Akses Menu Settings Panel" "$file" "$url"
        ;;

    5)
        file="/var/www/pterodactyl/app/Http/Controllers/Api/Client/Servers/ServerController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/ServerController.php"
        install_patch "Anti Akses Server Selain Pemilik" "$file" "$url"
        ;;

    6)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nests/EggController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/EggController.php"
        install_patch "Anti Hapus Egg Panel" "$file" "$url"
        ;;

    7)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nests/NestController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/NestController.php"
        install_patch "Anti Hapus Nest Panel" "$file" "$url"
        ;;

    8)
        file="/var/www/pterodactyl/app/Services/Servers/ServerDeletionService.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/ServerDeletionService.php"
        install_patch "Anti Hapus Server" "$file" "$url"
        ;;

    9)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/UserController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/UserController.php"
        install_patch "Anti Modifikasi Akun" "$file" "$url"
        ;;

    10)
        file="/var/www/pterodactyl/app/Services/Servers/DetailsModificationService.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/DetailsModificationService.php"
        install_patch "Anti Modifikasi Detail Server" "$file" "$url"
        ;;
esac