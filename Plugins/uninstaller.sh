#!/bin/bash

CLEAR="\e[0m"
RED="\e[31m"
GREEN="\e[32m"

restore_patch() {
    name="$1"
    file="$2"
    url="$3"

    echo "Menghapus $name"
    mkdir -p "$(dirname "$file")"

    if [ -f "$file.bak" ]; then
        cp "$file.bak" "$file"
        echo "$name Berhasil Di Uninstall."
        sleep 1
        return
    fi

    curl -fsSL "$url" -o "$file" >/dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo "Gagal mengembalikan file: $name"
        return
    fi

    echo "$name Berhasil Di Uninstall."
    sleep 1
}

uninstall_all() {
    bash "$0" 1
    bash "$0" 2
    bash "$0" 3
    bash "$0" 4
    bash "$0" 5
    bash "$0" 6
    bash "$0" 7
    bash "$0" 8
    bash "$0" 9
    bash "$0" 10

    echo "❖────────────────────❖"
    echo "Semua Uninstall Telah Di Selesaikan"
    echo "Terima Kasih Sudah Menggunakan Script MFSAVANA SECURITY INSTALLER"
    echo "❖────────────────────❖"
    exit
}

case "$1" in
    all)
        uninstall_all
        ;;

    1)
        file="/var/www/pterodactyl/app/Http/Controllers/Api/Client/Servers/FileController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/FileController.php"
        restore_patch "Anti Akses File Server Selain Pemilik" "$file" "$url"
        ;;

    2)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/LocationController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/LocationController.php"
        restore_patch "Anti Akses Menu Location Panel" "$file" "$url"
        ;;

    3)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nodes/NodeController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/NodeController.php"
        restore_patch "Anti Akses Menu Nodes Panel" "$file" "$url"
        ;;

    4)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Settings/IndexController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/IndexController.php"
        restore_patch "Anti Akses Menu Settings Panel" "$file" "$url"
        ;;

    5)
        file="/var/www/pterodactyl/app/Http/Controllers/Api/Client/Servers/ServerController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/ServerController.php"
        restore_patch "Anti Akses Server Selain Pemilik" "$file" "$url"
        ;;

    6)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nests/EggController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/EggController.php"
        restore_patch "Anti Hapus Egg Panel" "$file" "$url"
        ;;

    7)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nests/NestController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/NestController.php"
        restore_patch "Anti Hapus Nest Panel" "$file" "$url"
        ;;

    8)
        file="/var/www/pterodactyl/app/Services/Servers/ServerDeletionService.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/ServerDeletionService.php"
        restore_patch "Anti Hapus Server" "$file" "$url"
        ;;

    9)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/UserController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/UserController.php"
        restore_patch "Anti Modifikasi Akun" "$file" "$url"
        ;;

    10)
        file="/var/www/pterodactyl/app/Services/Servers/DetailsModificationService.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/DetailsModificationService.php"
        restore_patch "Anti Modifikasi Detail Server" "$file" "$url"
        ;;
esac