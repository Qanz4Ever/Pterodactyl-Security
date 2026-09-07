#!/usr/bin/env bash
# ==============================================================================
#  PTERODACTYL SECURITY INSTALLER MODULE
# ==============================================================================

CLEAR="\033[0m"
BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
CYAN="\033[0;36m"
DIM="\033[2m"

marker="Protect By Mfsavana"

install_patch() {
    local name="$1"
    local file="$2"
    local url="$3"

    if [ -f "$file" ] && grep -Fq -- "$marker" "$file" 2>/dev/null; then
        echo -e "  ${YELLOW}[!] SKIPPED:${CLEAR} $name is already protected."
        sleep 0.2
        return 0
    fi

    echo -e "  ${CYAN}[*] Installing:${CLEAR} $name..."
    mkdir -p "$(dirname "$file")"
    if [ -f "$file" ]; then
        cp "$file" "${file}.bak"
        echo -e "  ${DIM}[i] Backup created:${CLEAR} ${file}.bak"
    fi

    if curl -fsSL "$url" -o "$file" >/dev/null 2>&1; then
        echo -e "  ${GREEN}[✓] SUCCESS:${CLEAR} $name installed successfully."
        sleep 0.2
        return 0
    else
        echo -e "  ${RED}[✗] ERROR:${CLEAR} Failed to download patch for $name."
        return 1
    fi
}

install_all() {
    local mode="$1"

    echo -e "\n  ${BOLD}Applying patches for tier: ${GREEN}${mode}${CLEAR}\n"
    for i in {1..10}; do
        bash "$0" "$i" "$mode"
    done

    echo ""
    echo -e "  ${GREEN}${BOLD}─────────────────────────────────────────────────────────────${CLEAR}"
    echo -e "  ${GREEN}${BOLD}  All security patches have been successfully applied!       ${CLEAR}"
    echo -e "  ${GREEN}${BOLD}─────────────────────────────────────────────────────────────${CLEAR}"
}

case "$1" in
    all)
        install_all "$2"
        exit 0
        ;;

    1)
        file="/var/www/pterodactyl/app/Http/Controllers/Api/Client/Servers/FileController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/FileController.php"
        install_patch "Server File Isolation" "$file" "$url"
        ;;

    2)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/LocationController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/LocationController.php"
        install_patch "Location Panel Lockdown" "$file" "$url"
        ;;

    3)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nodes/NodeController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/NodeController.php"
        install_patch "Nodes Panel Lockdown" "$file" "$url"
        ;;

    4)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Settings/IndexController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/IndexController.php"
        install_patch "Settings Panel Lockdown" "$file" "$url"
        ;;

    5)
        file="/var/www/pterodactyl/app/Http/Controllers/Api/Client/Servers/ServerController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/ServerController.php"
        install_patch "Server Access Guard" "$file" "$url"
        ;;

    6)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nests/EggController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/EggController.php"
        install_patch "Anti-Egg Deletion Guard" "$file" "$url"
        ;;

    7)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/Nests/NestController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/NestController.php"
        install_patch "Anti-Nest Deletion Guard" "$file" "$url"
        ;;

    8)
        file="/var/www/pterodactyl/app/Services/Servers/ServerDeletionService.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/ServerDeletionService.php"
        install_patch "Anti-Server Deletion Guard" "$file" "$url"
        ;;

    9)
        file="/var/www/pterodactyl/app/Http/Controllers/Admin/UserController.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/UserController.php"
        install_patch "User Account Guard" "$file" "$url"
        ;;

    10)
        file="/var/www/pterodactyl/app/Services/Servers/DetailsModificationService.php"
        url="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Install/$2/DetailsModificationService.php"
        install_patch "Server Details Guard" "$file" "$url"
        ;;
esac
