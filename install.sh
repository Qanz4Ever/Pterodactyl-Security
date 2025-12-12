#!/bin/bash

CLEAR="\e[0m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"

RAW_BASE="https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/Plugins"

clear
echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════╗"
echo "║              𝙼𝙵𝚂𝙰𝚅𝙰𝙽𝙰 𝚂𝙴𝙲𝚄𝚁𝙸𝚃𝚈 𝙸𝙽𝚂𝚃𝙰𝙻𝙻𝙴𝚁              ║"
echo "║                 Secure. Simple. Safe.                 ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo -e "${CLEAR}"

if ! command -v curl >/dev/null 2>&1; then
    echo -e "${RED}Curl tidak ditemukan. Install curl terlebih dahulu.${CLEAR}"
    exit 1
fi

run_plugin() {
    action="$1"
    mode="$2"
    script_url="$RAW_BASE/$action.sh"
    if curl -fsSL "$script_url" >/tmp/plugin_exec.sh 2>/dev/null; then
        bash /tmp/plugin_exec.sh "$mode" "$selected_mode"
        rm -f /tmp/plugin_exec.sh
    else
        if [ -f "plugins/$action.sh" ]; then
            bash "plugins/$action.sh" "$mode" "$selected_mode"
        else
            echo -e "${RED}Plugin tidak ditemukan baik RAW maupun lokal.${CLEAR}"
            exit 1
        fi
    fi
}

selected_mode=""

run_main_menu() {
    while true; do
        echo -e "❖────────────────────❖"
        echo -e "[0] Install Anti Intip"
        echo -e "[1] Uninstall Anti Intip"
        echo -e "❖────────────────────❖"
        echo -ne "${CYAN}Select Option With Number To Continue: ${CLEAR}"
        read main_option
        echo
        case $main_option in
            0) choose_mode "installer"; return ;;
            1) choose_mode "uninstaller"; return ;;
            *) clear ;;
        esac
    done
}

choose_mode() {
    action="$1"
    clear
    echo -e "❖────────────────────❖"
    echo -e "[0] Hanya ID 1 Yang Bisa Mengakses"
    echo -e "[1] Hanya ID 1 & 2 Yang Bisa Mengakses"
    echo -e "[2] Hanya ID 1, 2, & 3 Yang Bisa Mengakses"
    echo -e "[3] Kembali Ke Menu"
    echo -e "❖────────────────────❖"
    echo -ne "${CYAN}Select Mode: ${CLEAR}"
    read mode
    case $mode in
        0) selected_mode="ID-1" ;;
        1) selected_mode="ID-1,2" ;;
        2) selected_mode="ID-1,2,3" ;;
        3) clear; run_main_menu; return ;;
        *) clear; choose_mode "$action"; return ;;
    esac
    echo
    echo
    echo
    if [ "$action" = "installer" ]; then
        run_install_menu
    else
        run_uninstall_menu
    fi
}

run_install_menu() {
    while true; do
        clear
        echo -e "❖────────────────────❖"
        echo "[0] Install Semua Anti Intip"
        echo "[1] Install Anti Akses File Server Selain Pemilik"
        echo "[2] Install Anti Akses Menu Location Panel"
        echo "[3] Install Anti Akses Menu Nodes Panel"
        echo "[4] Install Anti Akses Menu Settings Panel"
        echo "[5] Install Anti Akses Server Selain Pemilik"
        echo "[6] Install Anti Hapus Egg Panel"
        echo "[7] Install Anti Hapus Nest Panel"
        echo "[8] Install Anti Hapus Server"
        echo "[9] Install Anti Modifikasi Akun"
        echo "[10] Install Anti Modifikasi Detail Server"
        echo "[11] Kembali Ke Menu"
        echo -e "❖────────────────────❖"
        echo "Panel = Pterodactyl Panel"
        echo "Server = Container"
        echo -e "❖────────────────────❖"
        echo -ne "${CYAN}Select Option With Number To Continue: ${CLEAR}"
        read opt
        echo
        echo
        echo
        case $opt in
            0) run_plugin "installer" "all"; exit ;;
            1) run_plugin "installer" 1 ;;
            2) run_plugin "installer" 2 ;;
            3) run_plugin "installer" 3 ;;
            4) run_plugin "installer" 4 ;;
            5) run_plugin "installer" 5 ;;
            6) run_plugin "installer" 6 ;;
            7) run_plugin "installer" 7 ;;
            8) run_plugin "installer" 8 ;;
            9) run_plugin "installer" 9 ;;
            10) run_plugin "installer" 10 ;;
            11) clear; run_main_menu; return ;;
        esac
    done
}

run_uninstall_menu() {
    while true; do
        clear
        echo -e "❖────────────────────❖"
        echo "[0] Uninstall Semua Anti Intip"
        echo "[1] Uninstall Anti Akses File Server Selain Pemilik"
        echo "[2] Uninstall Anti Akses Menu Location Panel"
        echo "[3] Uninstall Anti Akses Menu Nodes Panel"
        echo "[4] Uninstall Anti Akses Menu Settings Panel"
        echo "[5] Uninstall Anti Akses Server Selain Pemilik"
        echo "[6] Uninstall Anti Hapus Egg Panel"
        echo "[7] Uninstall Anti Hapus Nest Panel"
        echo "[8] Uninstall Anti Hapus Server"
        echo "[9] Uninstall Anti Modifikasi Akun"
        echo "[10] Uninstall Anti Modifikasi Detail Server"
        echo "[11] Kembali Ke Menu"
        echo -e "❖────────────────────❖"
        echo "Panel = Pterodactyl Panel"
        echo "Server = Container"
        echo -e "❖────────────────────❖"
        echo -ne "${CYAN}Select Option With Number To Continue: ${CLEAR}"
        read opt
        echo
        echo
        echo
        case $opt in
            0) run_plugin "uninstaller" "all"; exit ;;
            1) run_plugin "uninstaller" 1 ;;
            2) run_plugin "uninstaller" 2 ;;
            3) run_plugin "uninstaller" 3 ;;
            4) run_plugin "uninstaller" 4 ;;
            5) run_plugin "uninstaller" 5 ;;
            6) run_plugin "uninstaller" 6 ;;
            7) run_plugin "uninstaller" 7 ;;
            8) run_plugin "uninstaller" 8 ;;
            9) run_plugin "uninstaller" 9 ;;
            10) run_plugin "uninstaller" 10 ;;
            11) clear; run_main_menu; return ;;
        esac
    done
}

run_main_menu
