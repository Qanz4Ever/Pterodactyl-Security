#!/usr/bin/env bash
# ==============================================================================
#  PTERODACTYL SECURITY UNINSTALLER MODULE
# ==============================================================================

CLEAR="\033[0m"
BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
CYAN="\033[0;36m"
DIM="\033[2m"

restore_patch() {
    local name="$1"
    local file="$2"
    local url="$3"

    echo -e "  ${CYAN}[*] Restoring:${CLEAR} $name..."
    mkdir -p "$(dirname "$file")"

    if [ -f "${file}.bak" ]; then
        cp "${file}.bak" "$file"
        echo -e "  ${GREEN}[✓] RESTORED:${CLEAR} $name restored from local backup (.bak)."
        sleep 0.2
        return 0
    fi

    if curl -fsSL "$url" -o "$file" >/dev/null 2>&1; then
        echo -e "  ${GREEN}[✓] RESTORED:${CLEAR} $name restored from default clean template."
        sleep 0.2
        return 0
    else
        echo -e "  ${RED}[✗] ERROR:${CLEAR} Failed to restore $name."
        return 1
    fi
}

uninstall_all() {
    echo -e "\n  ${BOLD}Restoring all original controllers...${CLEAR}\n"
    for i in {1..10}; do
        bash "$0" "$i"
    done

    echo ""
    echo -e "  ${GREEN}${BOLD}─────────────────────────────────────────────────────────────${CLEAR}"
    echo -e "  ${GREEN}${BOLD}  All security patches have been reverted successfully!       ${CLEAR}"
    echo -e "  ${GREEN}${BOLD}─────────────────────────────────────────────────────────────${CLEAR}"
    exit 0
}

case "$1" in
    all)
        uninstall_all
        ;;

    1)
        file="/var/www/pterodactyl/app/Http/Controllers/Api/Client/Servers/FileController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/FileController.php"
        restore_patch "Server File Isolation" "$file" "$url"
        ;;

    2)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/LocationController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/LocationController.php"
        restore_patch "Location Panel Lockdown" "$file" "$url"
        ;;

    3)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nodes/NodeController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/NodeController.php"
        restore_patch "Nodes Panel Lockdown" "$file" "$url"
        ;;

    4)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Settings/IndexController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/IndexController.php"
        restore_patch "Settings Panel Lockdown" "$file" "$url"
        ;;

    5)
        file="/var/www/pterodactyl/app/Http/Controllers/Api/Client/Servers/ServerController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/ServerController.php"
        restore_patch "Server Access Guard" "$file" "$url"
        ;;

    6)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nests/EggController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/EggController.php"
        restore_patch "Anti-Egg Deletion Guard" "$file" "$url"
        ;;

    7)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nests/NestController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/NestController.php"
        restore_patch "Anti-Nest Deletion Guard" "$file" "$url"
        ;;

    8)
        file="/var/www/pterodactyl/app/Services/Servers/ServerDeletionService.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/ServerDeletionService.php"
        restore_patch "Anti-Server Deletion Guard" "$file" "$url"
        ;;

    9)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/UserController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/UserController.php"
        restore_patch "User Account Guard" "$file" "$url"
        ;;

    10)
        file="/var/www/pterodactyl/app/Services/Servers/DetailsModificationService.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Uninstall/DetailsModificationService.php"
        restore_patch "Server Details Guard" "$file" "$url"
        ;;
esac
