#!/bin/bash

CLEAR="\e[0m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"

clear
echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════╗"
echo "║              𝙼𝙵𝚂𝙰𝚅𝙰𝙽𝙰 𝚂𝙴𝙲𝚄𝚁𝙸𝚃𝚈 𝙸𝙽𝚂𝚃𝙰𝙻𝙻𝙴𝚁              ║"
echo "║                 Secure. Simple. Safe.                 ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo -e "${CLEAR}"

if ! command -v curl &> /dev/null; then
    echo -e "${RED}Curl tidak ditemukan. Install dengan: apt install curl${CLEAR}"
    exit 1
fi

selected_mode=""
run_install_menu() {
    while true; do
        echo -e "❖────────────────────❖"
        echo -e "[0] Install Anti Intip"
        echo -e "[1] Uninstall Anti Intip"
        echo -e "❖────────────────────❖"
        echo -ne "${CYAN}Select Option With Number To Continue: ${CLEAR}"
        read main_option
        echo
        case $main_option in
            0) choose_mode "install"; return ;;
            1) choose_mode "uninstall"; return ;;
            *) echo "Input salah."; sleep 1; clear; return ;;
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
        3) clear; run_install_menu; return ;;
        *) clear; choose_mode "$action"; return ;;
    esac
    echo
    echo
    echo
    if [ "$action" = "install" ]; then
        load_install_menu
    else
        load_uninstall_menu
    fi
}

load_install_menu() {
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
            0) bash plugins/installer.sh all "$selected_mode"; exit ;;
            1) bash plugins/installer.sh 1 "$selected_mode" ;;
            2) bash plugins/installer.sh 2 "$selected_mode" ;;
            3) bash plugins/installer.sh 3 "$selected_mode" ;;
            4) bash plugins/installer.sh 4 "$selected_mode" ;;
            5) bash plugins/installer.sh 5 "$selected_mode" ;;
            6) bash plugins/installer.sh 6 "$selected_mode" ;;
            7) bash plugins/installer.sh 7 "$selected_mode" ;;
            8) bash plugins/installer.sh 8 "$selected_mode" ;;
            9) bash plugins/installer.sh 9 "$selected_mode" ;;
            10) bash plugins/installer.sh 10 "$selected_mode" ;;
            11) clear; run_install_menu; return ;;
            *) echo "Input salah."; sleep 1 ;;
        esac
    done
}

load_uninstall_menu() {
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
            0) bash plugins/uninstaller.sh all; exit ;;
            1) bash plugins/uninstaller.sh 1 ;;
            2) bash plugins/uninstaller.sh 2 ;;
            3) bash plugins/uninstaller.sh 3 ;;
            4) bash plugins/uninstaller.sh 4 ;;
            5) bash plugins/uninstaller.sh 5 ;;
            6) bash plugins/uninstaller.sh 6 ;;
            7) bash plugins/uninstaller.sh 7 ;;
            8) bash plugins/uninstaller.sh 8 ;;
            9) bash plugins/uninstaller.sh 9 ;;
            10) bash plugins/uninstaller.sh 10 ;;
            11) clear; run_install_menu; return ;;
            *) echo "Input salah."; sleep 1 ;;
        esac
    done
}

run_install_menu