#!/bin/bash

clear

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════╗"
echo "║              𝙼𝙵𝚂𝙰𝚅𝙰𝙽𝙰 𝚂𝙴𝙲𝚄𝚁𝙸𝚃𝚈 𝙸𝙽𝚂𝚃𝙰𝙻𝙻𝙴𝚁              ║"
echo "║                   𝙎𝙚𝙘𝙪𝙧𝙚. 𝙎𝙞𝙢𝙥𝙡𝙚. 𝙎𝙖𝙛𝙚.               ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo -e "${RESET}"

if ! command -v curl &> /dev/null; then
    echo -e "${RED}❌ | 𝘾𝙐𝙍𝙇 𝙏𝙞𝙙𝙖𝙠 𝘿𝙞𝙩𝙚𝙢𝙪𝙠𝙖𝙣,𝙎𝙞𝙡𝙖𝙝𝙠𝙖𝙣 𝙄𝙣𝙨𝙩𝙖𝙡𝙡 𝘿𝙪𝙡𝙪 𝘿𝙚𝙣𝙜𝙖𝙣 : 𝙖𝙥𝙩 𝙞𝙣𝙨𝙩𝙖𝙡𝙡 𝙘𝙪𝙧𝙡${RESET}"
    exit 1
fi

install_patch() {
    local name="$1"
    local file="$2"
    local url="$3"

    echo
    read -p "📦 | 𝘼𝙥𝙖𝙠𝙖𝙝 𝘼𝙣𝙙𝙖 𝙄𝙣𝙜𝙞𝙣 𝙈𝙚𝙣𝙜𝙞𝙣𝙨𝙩𝙖𝙡𝙡 $name? (𝗬/𝗡): " jawab
    if [[ "$jawab" =~ ^[Yy]$ ]]; then
        echo -e "\n⚙️ | 𝙈𝙚𝙣𝙜𝙞𝙣𝙨𝙩𝙖𝙡𝙡 ${YELLOW}$name${RESET}..."
        
        if [ -f "$file" ]; then
            cp "$file" "${file}.bak"
            echo -e "${GREEN}💾 | 𝘽𝙖𝙘𝙠𝙪𝙥 𝙁𝙞𝙡𝙚 𝙏𝙚𝙡𝙖𝙝 𝘿𝙞 𝘽𝙪𝙖𝙩 : ${file}.bak${RESET}"
        else
            echo -e "${RED}⚠️ | 𝙁𝙞𝙡𝙚 𝙋𝙖𝙩𝙝 𝙏𝙞𝙙𝙖𝙠 𝘿𝙞𝙩𝙚𝙢𝙪𝙠𝙖𝙣 : ${RESET} $file"
            return
        fi

        echo -e "📥 | 𝙈𝙚𝙣𝙜𝙪𝙣𝙙𝙪𝙝 𝙁𝙞𝙡𝙚 𝙋𝙖𝙩𝙝..."
        curl -fsSL "$url" -o "$file"

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ | 𝙋𝙖𝙩𝙝 𝘽𝙚𝙧𝙝𝙖𝙨𝙞𝙡 𝘿𝙞 𝙏𝙚𝙧𝙖𝙥𝙠𝙖𝙣.${RESET}"
        else
            echo -e "${RED}❌ | 𝙂𝙖𝙜𝙖𝙡 𝙈𝙚𝙣𝙜𝙪𝙣𝙙𝙪𝙝 𝙁𝙞𝙡𝙚 𝙋𝙖𝙩𝙝 𝘿𝙖𝙧𝙞 :  $name.${RESET}"
            echo -e "   𝙃𝙪𝙗𝙪𝙣𝙜𝙞 𝘿𝙚𝙫𝙚𝙡𝙤𝙥𝙚𝙧 𝙅𝙞𝙠𝙖 𝙀𝙧𝙧𝙤𝙧 𝙄𝙣𝙞 𝙏𝙚𝙧𝙪𝙨 𝙏𝙚𝙧𝙟𝙖𝙙𝙞."
            return
        fi

        sleep 1
        echo -e "${GREEN}✔️ | $name 𝙏𝙚𝙡𝙖𝙝 𝘿𝙞 𝙏𝙚𝙧𝙖𝙥𝙠𝙖𝙣 𝘿𝙚𝙣𝙜𝙖𝙣 𝙎𝙪𝙠𝙨𝙚𝙨.${RESET}"
    else
        echo -e "${YELLOW}🚫 | 𝙄𝙣𝙨𝙩𝙖𝙡𝙖𝙨𝙞 $name 𝘿𝙞𝙗𝙖𝙩𝙖𝙡𝙠𝙖𝙣.${RESET}"
    fi
}

# === Patch List ===
install_patch "𝘼𝙣𝙩𝙞 𝙈𝙤𝙙𝙞𝙛𝙞𝙠𝙖𝙨𝙞 𝘿𝙚𝙩𝙖𝙞𝙡 𝙎𝙚𝙧𝙫𝙚𝙧" \
"/var/www/pterodactyl/app/Services/Servers/DetailsModificationService.php" \
"https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/DetailsModificationService.php?token=GHSAT0AAAAAADNGOKTTTMZE3M3TXWGZKF2Y2IFP62A"

install_patch "𝘼𝙣𝙩𝙞 𝘼𝙠𝙨𝙚𝙨 𝙁𝙞𝙡𝙚𝙨 𝙎𝙚𝙧𝙫𝙚𝙧 𝙎𝙚𝙡𝙖𝙞𝙣 𝙋𝙚𝙢𝙞𝙡𝙞𝙠" \
"/var/www/pterodactyl/app/Http/Controllers/Api/Client/Servers/FileController.php" \
"https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/FileController.php?token=GHSAT0AAAAAADNGOKTT5STMTAMZSI474ABE2IFQKCQ"

install_patch "𝘼𝙣𝙩𝙞 𝘼𝙠𝙨𝙚𝙨 𝙈𝙚𝙣𝙪 𝙎𝙚𝙩𝙩𝙞𝙣𝙜𝙨 𝙋𝙖𝙣𝙚𝙡" \
"/var/www/pterodactyl/app/Http/Controllers/Admin/Settings/IndexController.php" \
"https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/IndexController.php?token=GHSAT0AAAAAADNGOKTT4KONJVCXW34EM5ZO2IFQLNA"

install_patch "𝘼𝙣𝙩𝙞 𝘼𝙠𝙨𝙚𝙨 𝙈𝙚𝙣𝙪 𝙇𝙤𝙘𝙖𝙩𝙞𝙤𝙣 𝙋𝙖𝙣𝙚𝙡" \
"/var/www/pterodactyl/app/Http/Controllers/Admin/LocationController.php" \
"https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/LocationController.php?token=GHSAT0AAAAAADNGOKTT2DBYRETO5FYB2UCU2IFQMMA"

install_patch "𝘼𝙣𝙩𝙞 𝙃𝙖𝙥𝙪𝙨 𝙉𝙚𝙨𝙩 𝙋𝙖𝙣𝙚𝙡" \
"/var/www/pterodactyl/app/Http/Controllers/Admin/Nests/NestController.php" \
"https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/NestController.php?token=GHSAT0AAAAAADNGOKTT62QPZ5Y6O3E5WY3I2IFQNEA"

install_patch "𝘼𝙣𝙩𝙞 𝘼𝙠𝙨𝙚𝙨 𝙈𝙚𝙣𝙪 𝙉𝙤𝙙𝙚𝙨 𝙋𝙖𝙣𝙚𝙡" \
"/var/www/pterodactyl/app/Http/Controllers/Admin/NodesController.php" \
"https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/NodesController.php?token=GHSAT0AAAAAADNGOKTSP463NJCRKWBW4ZOC2IFQOAQ"

install_patch "𝘼𝙣𝙩𝙞 𝙃𝙖𝙥𝙪𝙨 𝙎𝙚𝙧𝙫𝙚𝙧" \
"/var/www/pterodactyl/app/Services/Servers/ServerDeletionService.php" \
"https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/ServerDeletionService.php?token=GHSAT0AAAAAADNGOKTSPWI7N4ODBIFI5AQG2IFQPBA"

install_patch "𝘼𝙣𝙩𝙞 𝙐𝙗𝙖𝙝 𝘿𝙖𝙣 𝙃𝙖𝙥𝙪𝙨 𝘼𝙠𝙪𝙣" \
"/var/www/pterodactyl/app/Http/Controllers/Admin/UserController.php" \
"https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/UserController.php?token=GHSAT0AAAAAADNGOKTTVSAX5ADEJIIPCXKY2IFQP2A"

echo -e "\n${CYAN}==============================================================="
echo -e "🎉 | 𝙎𝙚𝙢𝙪𝙖 𝙄𝙣𝙨𝙩𝙖𝙡𝙖𝙨𝙞 𝙏𝙚𝙡𝙖𝙝 𝙎𝙚𝙡𝙚𝙨𝙖𝙞."
echo -e "𝙏𝙚𝙧𝙞𝙢𝙖 𝙆𝙖𝙨𝙞𝙝 𝙏𝙚𝙡𝙖𝙝 𝙈𝙚𝙣𝙜𝙜𝙪𝙣𝙖𝙠𝙖𝙣 𝙎𝙘𝙧𝙞𝙥𝙩 ${YELLOW}𝙼𝙵𝚂𝙰𝚅𝙰𝙽𝙰 𝚂𝙴𝙲𝚄𝚁𝙸𝚃𝚈 𝙸𝙽𝚂𝚃𝙰𝙻𝙻𝙴𝚁${RESET}${CYAN}."
echo "==============================================================="
echo -e "${RESET}"
