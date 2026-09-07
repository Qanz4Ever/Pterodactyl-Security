#!/usr/bin/env bash
# ==============================================================================
#  PTERODACTYL SECURITY INSTALLER (MFSAVANA)
#  Automated Access Control & Anti-Tamper Hardening Suite
#  Repository: https://github.com/Qanz4Ever/Pterodactyl-Security
# ==============================================================================

set -e

# Color Definitions
RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"
CYAN="\033[0;36m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"

RAW_BASE="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/main/Plugins"
PANEL_DIR="/var/www/pterodactyl"
MARKER="Protect By Mfsavana"

prompt_read() {
    local prompt="$1"
    local var_name="$2"
    if [ -e /dev/tty ]; then
        read -r -p "$(echo -e "$prompt")" "$var_name" </dev/tty
    else
        read -r -p "$(echo -e "$prompt")" "$var_name"
    fi
}

pause_key() {
    echo ""
    prompt_read "${DIM}Press [ENTER] to continue...${RESET}" dummy
}

print_header() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "┌─────────────────────────────────────────────────────────────┐"
    echo "│                PTERODACTYL SECURITY SUITE                   │"
    echo "│              Access Hardening & Anti-Tamper                 │"
    echo "│                   Version 2.0 • @mfsavana                   │"
    echo "└─────────────────────────────────────────────────────────────┘"
    echo -e "${RESET}"
}

check_prerequisites() {
    if ! command -v curl >/dev/null 2>&1; then
        echo -e "${RED}[ERROR] curl is not installed. Please install curl first.${RESET}"
        exit 1
    fi

    if [ "$EUID" -ne 0 ] 2>/dev/null; then
        echo -e "${YELLOW}[WARNING] This script should ideally be run as root or with sudo.${RESET}"
        echo -e "${DIM}Ensure you have write permissions to ${PANEL_DIR}.${RESET}\n"
    fi
}

run_plugin() {
    local action="$1"
    local target="$2"
    local mode="$3"
    local script_url="${RAW_BASE}/${action}.sh"

    if curl -fsSL "$script_url" >/tmp/plugin_exec.sh 2>/dev/null; then
        bash /tmp/plugin_exec.sh "$target" "$mode"
        rm -f /tmp/plugin_exec.sh
    elif [ -f "Plugins/${action}.sh" ]; then
        bash "Plugins/${action}.sh" "$target" "$mode"
    elif [ -f "plugins/${action}.sh" ]; then
        bash "plugins/${action}.sh" "$target" "$mode"
    else
        echo -e "${RED}[ERROR] Failed to load ${action}.sh (neither remote nor local found).${RESET}"
        exit 1
    fi
}

clear_panel_cache() {
    if [ -d "$PANEL_DIR" ]; then
        echo -e "\n${CYAN}[*] Clearing Pterodactyl Panel cache...${RESET}"
        cd "$PANEL_DIR" || return
        if command -v php >/dev/null 2>&1; then
            php artisan view:clear >/dev/null 2>&1 || true
            php artisan config:clear >/dev/null 2>&1 || true
            php artisan route:clear >/dev/null 2>&1 || true
            php artisan cache:clear >/dev/null 2>&1 || true
            echo -e "${GREEN}[✓] Cache successfully flushed.${RESET}"
        else
            echo -e "${YELLOW}[!] PHP CLI not found. Please clear cache manually.${RESET}"
        fi
    fi
}

ask_clear_cache() {
    echo ""
    prompt_read "${CYAN}Do you want to clear the Pterodactyl cache now? [Y/n]: ${RESET}" ans
    case "$ans" in
        [nN][oO]|[nN])
            echo -e "${DIM}Cache clearing skipped.${RESET}"
            ;;
        *)
            clear_panel_cache
            ;;
    esac
}

check_status() {
    print_header
    echo -e "${BOLD}Current Protection Status in ${PANEL_DIR}:${RESET}\n"

    local files=(
        "app/Http/Controllers/Api/Client/Servers/FileController.php"
        "app/Http/Controllers/Admin/LocationController.php"
        "app/Http/Controllers/Admin/Nodes/NodeController.php"
        "app/Http/Controllers/Admin/Settings/IndexController.php"
        "app/Http/Controllers/Api/Client/Servers/ServerController.php"
        "app/Http/Controllers/Admin/Nests/EggController.php"
        "app/Http/Controllers/Admin/Nests/NestController.php"
        "app/Services/Servers/ServerDeletionService.php"
        "app/Http/Controllers/Admin/UserController.php"
        "app/Services/Servers/DetailsModificationService.php"
    )

    local names=(
        "Server File Isolation"
        "Location Panel Lockdown"
        "Nodes Panel Lockdown"
        "Settings Panel Lockdown"
        "Server Access Guard"
        "Anti-Egg Deletion Guard"
        "Anti-Nest Deletion Guard"
        "Anti-Server Deletion Guard"
        "User Account Guard"
        "Server Details Guard"
    )

    local protected_count=0
    for i in "${!files[@]}"; do
        local target="${PANEL_DIR}/${files[$i]}"
        local name="${names[$i]}"
        if [ -f "$target" ]; then
            if grep -Fq -- "$MARKER" "$target" 2>/dev/null; then
                printf "  ${GREEN}[✓] PROTECTED   ${RESET} %-28s ${DIM}(%s)${RESET}\n" "$name" "$(basename "$target")"
                ((protected_count++))
            else
                printf "  ${YELLOW}[-] DEFAULT     ${RESET} %-28s ${DIM}(%s)${RESET}\n" "$name" "$(basename "$target")"
            fi
        else
            printf "  ${RED}[✗] NOT FOUND   ${RESET} %-28s ${DIM}(%s)${RESET}\n" "$name" "$(basename "$target")"
        fi
    done

    echo -e "\n${BOLD}Summary:${RESET} ${protected_count}/10 modules currently protected."
    pause_key
}

run_install_menu() {
    local mode="$1"
    while true; do
        print_header
        echo -e "${BOLD}Select Modules to Install (Target Mode: ${GREEN}${mode}${RESET}${BOLD}):${RESET}\n"
        echo -e "  ${CYAN}[A]${RESET} ${BOLD}Install All Modules${RESET} (Recommended)"
        echo -e "  ─────────────────────────────────────────────────────────"
        echo -e "  ${CYAN}[1]${RESET}  Server File Isolation         ${DIM}(FileController.php)${RESET}"
        echo -e "  ${CYAN}[2]${RESET}  Location Panel Lockdown       ${DIM}(LocationController.php)${RESET}"
        echo -e "  ${CYAN}[3]${RESET}  Nodes Panel Lockdown          ${DIM}(NodeController.php)${RESET}"
        echo -e "  ${CYAN}[4]${RESET}  Settings Panel Lockdown       ${DIM}(IndexController.php)${RESET}"
        echo -e "  ${CYAN}[5]${RESET}  Server Access Guard           ${DIM}(ServerController.php)${RESET}"
        echo -e "  ${CYAN}[6]${RESET}  Anti-Egg Deletion Guard       ${DIM}(EggController.php)${RESET}"
        echo -e "  ${CYAN}[7]${RESET}  Anti-Nest Deletion Guard      ${DIM}(NestController.php)${RESET}"
        echo -e "  ${CYAN}[8]${RESET}  Anti-Server Deletion Guard    ${DIM}(ServerDeletionService.php)${RESET}"
        echo -e "  ${CYAN}[9]${RESET}  User Account Guard            ${DIM}(UserController.php)${RESET}"
        echo -e "  ${CYAN}[10]${RESET} Server Details Guard          ${DIM}(DetailsModificationService.php)${RESET}"
        echo -e "  ─────────────────────────────────────────────────────────"
        echo -e "  ${YELLOW}[0]${RESET}  Back to Protection Tier Menu"
        echo ""

        local opt
        prompt_read "${CYAN}Enter option [A/0-10]: ${RESET}" opt
        echo ""

        case "$opt" in
            [aA])
                echo -e "${BOLD}Installing all modules...${RESET}\n"
                run_plugin "installer" "all" "$mode"
                ask_clear_cache
                pause_key
                return
                ;;
            [1-9]|10)
                run_plugin "installer" "$opt" "$mode"
                ask_clear_cache
                pause_key
                ;;
            0)
                return
                ;;
            *)
                echo -e "${RED}[!] Invalid selection. Please try again.${RESET}"
                sleep 1
                ;;
        esac
    done
}

choose_mode() {
    while true; do
        print_header
        echo -e "${BOLD}Select Protection Whitelist Tier:${RESET}\n"
        echo -e "  ${CYAN}[1]${RESET} Mode 1 : ${BOLD}Strict Admin${RESET}     (User ID: 1 only)"
        echo -e "  ${CYAN}[2]${RESET} Mode 2 : ${BOLD}Dual Admin${RESET}       (User IDs: 1 & 2)"
        echo -e "  ${CYAN}[3]${RESET} Mode 3 : ${BOLD}Executive Team${RESET}   (User IDs: 1, 2, & 3)"
        echo -e "  ─────────────────────────────────────────────────────────"
        echo -e "  ${YELLOW}[0]${RESET} Back to Main Menu"
        echo ""

        local mode_opt
        prompt_read "${CYAN}Enter tier [0-3]: ${RESET}" mode_opt
        echo ""

        case "$mode_opt" in
            1) run_install_menu "ID-1"; return ;;
            2) run_install_menu "ID-1,2"; return ;;
            3) run_install_menu "ID-1,2,3"; return ;;
            0) return ;;
            *)
                echo -e "${RED}[!] Invalid choice. Please select 0, 1, 2, or 3.${RESET}"
                sleep 1
                ;;
        esac
    done
}

run_uninstall_menu() {
    while true; do
        print_header
        echo -e "${BOLD}Select Modules to Uninstall / Rollback:${RESET}\n"
        echo -e "  ${YELLOW}[A]${RESET} ${BOLD}Uninstall All Modules${RESET} (Restore everything)"
        echo -e "  ─────────────────────────────────────────────────────────"
        echo -e "  ${CYAN}[1]${RESET}  Server File Isolation         ${DIM}(FileController.php)${RESET}"
        echo -e "  ${CYAN}[2]${RESET}  Location Panel Lockdown       ${DIM}(LocationController.php)${RESET}"
        echo -e "  ${CYAN}[3]${RESET}  Nodes Panel Lockdown          ${DIM}(NodeController.php)${RESET}"
        echo -e "  ${CYAN}[4]${RESET}  Settings Panel Lockdown       ${DIM}(IndexController.php)${RESET}"
        echo -e "  ${CYAN}[5]${RESET}  Server Access Guard           ${DIM}(ServerController.php)${RESET}"
        echo -e "  ${CYAN}[6]${RESET}  Anti-Egg Deletion Guard       ${DIM}(EggController.php)${RESET}"
        echo -e "  ${CYAN}[7]${RESET}  Anti-Nest Deletion Guard      ${DIM}(NestController.php)${RESET}"
        echo -e "  ${CYAN}[8]${RESET}  Anti-Server Deletion Guard    ${DIM}(ServerDeletionService.php)${RESET}"
        echo -e "  ${CYAN}[9]${RESET}  User Account Guard            ${DIM}(UserController.php)${RESET}"
        echo -e "  ${CYAN}[10]${RESET} Server Details Guard          ${DIM}(DetailsModificationService.php)${RESET}"
        echo -e "  ─────────────────────────────────────────────────────────"
        echo -e "  ${YELLOW}[0]${RESET}  Back to Main Menu"
        echo ""

        local opt
        prompt_read "${CYAN}Enter option [A/0-10]: ${RESET}" opt
        echo ""

        case "$opt" in
            [aA])
                echo -e "${BOLD}Uninstalling all modules...${RESET}\n"
                run_plugin "uninstaller" "all" ""
                ask_clear_cache
                pause_key
                return
                ;;
            [1-9]|10)
                run_plugin "uninstaller" "$opt" ""
                ask_clear_cache
                pause_key
                ;;
            0)
                return
                ;;
            *)
                echo -e "${RED}[!] Invalid selection. Please try again.${RESET}"
                sleep 1
                ;;
        esac
    done
}

run_main_menu() {
    check_prerequisites

    while true; do
        print_header
        echo -e "${BOLD}Main Menu:${RESET}\n"
        echo -e "  ${GREEN}[1]${RESET} Install Security Hardening"
        echo -e "  ${YELLOW}[2]${RESET} Uninstall / Rollback Patches"
        echo -e "  ${BLUE}[3]${RESET} Check Protection Status"
        echo -e "  ─────────────────────────────────────────────────────────"
        echo -e "  ${RED}[0]${RESET} Exit"
        echo ""

        local main_choice
        prompt_read "${CYAN}Select an option [0-3]: ${RESET}" main_choice
        echo ""

        case "$main_choice" in
            1) choose_mode ;;
            2) run_uninstall_menu ;;
            3) check_status ;;
            0)
                echo -e "${GREEN}Thank you for using Pterodactyl Security Suite. Stay secure!${RESET}\n"
                exit 0
                ;;
            *)
                echo -e "${RED}[!] Invalid option. Please select 0, 1, 2, or 3.${RESET}"
                sleep 1
                ;;
        esac
    done
}

run_main_menu
