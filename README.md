# 𝙼𝙵𝚂𝙰𝚅𝙰𝙽𝙰 𝚂𝙴𝙲𝚄𝚁𝙸𝚃𝚈 𝙸𝙽𝚂𝚃𝙰𝙻𝙻𝙴𝚁
Sistem perlindungan otomatis untuk Pterodactyl Panel.  
Didesain untuk mencegah akses ilegal, modifikasi berbahaya, dan penghapusan data penting.  
Installer ini mendukung mode keamanan berdasarkan ID pengguna panel.

---

## ✦ Fitur Utama

### • Anti Akses Tidak Sah
Mencegah user selain pemilik server untuk:
- Melihat file
- Mengakses server
- Mengakses panel sensitive (Nodes, Location, Settings)

### • Anti Penghapusan Berbahaya
Blokir:
- Hapus Egg
- Hapus Nest
- Hapus Server
- Modifikasi akun user
- Modifikasi detail server

### • Sistem Mode Keamanan Berdasarkan ID
Pilih mode:
- **ID 1 saja**
- **ID 1 & 2**
- **ID 1, 2 & 3**

Semua patch otomatis menyesuaikan file sesuai mode yang dipilih.

---

## ✦ Cara Install

Jalankan perintah:

```bash
apt install curl -y
curl -o install.sh https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/install.sh
chmod +x install.sh
dos2unix install.sh
bash install.sh
```

Installer akan menampilkan menu:
- Install Anti Intip
- Uninstall Anti Intip
- Mode ID Protection
- Installer Modules
- Uninstaller Modules

---

## ✦ Cara Kerja Sistem

### 1. **Installer**
- Mengecek apakah patch sudah terpasang melalui marker:
  Protect By Mfsavana

- Jika sudah ada → dilewati otomatis  
- Jika belum → patch dipasang dan file asli di-backup `.bak`  

### 2. **Uninstaller**
- Jika tersedia backup `.bak`, maka file asli dipulihkan  
- Jika tidak ada, mengambil file default dari folder `Uninstall/`

---

## ✦ Patch Yang Didukung

### • Akses Panel:
- Location Panel  
- Nodes Panel  
- Settings Panel  

### • Akses Server:
- Anti akses server selain pemilik  
- Anti akses file server selain pemilik  

### • Proteksi Penghapusan:
- Egg  
- Nest  
- Server  

### • Proteksi Modifikasi:
- Akun  
- Detail server  

Semua patch otomatis mengarah ke file yang benar sesuai Pterodactyl.

---

## ✦ Keamanan

✔ Tidak ada data yang dikirim ke luar  
✔ Semua patch bersifat open-source  
✔ Backup otomatis sebelum overwrite  
✔ Mudah dipulihkan kapan saja menggunakan uninstaller  

---

## ✦ Lisensi

Project ini open-source dan bebas digunakan.  
Reupload ke GitHub diperbolehkan dengan mencantumkan kredit kepada:

**Developer: @mfsavana**

---

## ✦ Catatan Penting

Beberapa terminal tidak mendukung font unicode.  
Header dan footer installer menggunakan unicode, tetapi menu menggunakan font ASCII normal agar kompatibel di semua sistem.

---

## 📜 License

This project uses a **dual-license system**:

---

### **1. Apache License 2.0 (Primary License)**

The general project, documentation, and all non-restricted components are licensed under the **Apache License 2.0**.

You may read the full license here:  
🔗 https://www.apache.org/licenses/LICENSE-2.0

---

### **2. MFSAVANA SECURITY LICENSE v1.0 (Secondary / Restricted License)**

Certain files in this repository are protected and licensed under the  
**MFSAVANA SECURITY LICENSE v1.0**.

Files covered by this restrictive license include (but are not limited to):

- Security patches  
- Installer scripts  
- Uninstaller scripts  
- Anti-modification systems  
- Anti-access controllers  
- Any file containing the marker: **"Protect By Mfsavana"**

Under this license, the following actions are **strictly prohibited**:

- Reuploading or redistributing the protected files  
- Selling or commercially repackaging the script or any part of it  
- Publishing modified versions  
- Removing or altering credit lines, copyrights, or markers  
- Sharing modified or original versions publicly  

These files are **source-available but NOT open-source**.

By using this project, you agree to follow both licenses depending on the file you access.

---

© 2025 Qanz4Ever / Mfsavana — All Rights Reserved.
