# Pterodactyl Security Installer (MFSAVANA)

Automated security hardening and access control patcher for Pterodactyl Panel. Restricts sensitive administrative panels, blocks unauthorized server snooping, and prevents critical data deletion based on whitelisted User IDs.

---

## ✦ Overview

Default Pterodactyl installations grant broad permissions to panel administrators and sub-users. **Pterodactyl Security Installer** patches core controllers and services to strictly isolate servers and lock down administrative sections by whitelisting specific User IDs (e.g., Owner/Root admin only).

### Key Highlights
- **Zero Configuration**: Interactive CLI menu with single-command deployment.
- **Non-Destructive**: Backs up target files (`.bak`) before applying any patch.
- **Idempotent**: Detects existing patch signatures (`Protect By Mfsavana`) to prevent redundant patching.
- **Modular or All-in-One**: Install all protection patches at once or apply individual modules.
- **Built-in Rollback**: Restore from local `.bak` backups or default panel controller fallbacks.
- **Privacy-Friendly**: No external data collection or telemetry; operations run entirely locally.

---

## ✦ Security Protection Modules

| # | Module | Target File Path | Description |
|---|--------|------------------|-------------|
| **1** | **Server File Isolation** | `app/Http/Controllers/Api/Client/Servers/FileController.php` | Restricts file manager access strictly to the verified server owner or whitelisted IDs. |
| **2** | **Location Lockdown** | `app/Http/Controllers/Admin/LocationController.php` | Blocks unauthorized access to Admin Locations management. |
| **3** | **Node Lockdown** | `app/Http/Controllers/Admin/Nodes/NodeController.php` | Prevents unauthorized users from viewing or modifying Nodes. |
| **4** | **Settings Lockdown** | `app/Http/Controllers/Admin/Settings/IndexController.php` | Protects global panel configuration from unauthorized tampering. |
| **5** | **Server Access Guard** | `app/Http/Controllers/Api/Client/Servers/ServerController.php` | Prevents non-owners from accessing server consoles and controls. |
| **6** | **Anti-Egg Deletion** | `app/Http/Controllers/Admin/Nests/EggController.php` | Blocks accidental or malicious deletion of panel eggs. |
| **7** | **Anti-Nest Deletion** | `app/Http/Controllers/Admin/Nests/NestController.php` | Blocks accidental or malicious deletion of panel nests. |
| **8** | **Anti-Server Deletion** | `app/Services/Servers/ServerDeletionService.php` | Restricts the server deletion pipeline to whitelisted IDs only. |
| **9** | **Account Guard** | `app/Http/Controllers/Admin/UserController.php` | Prevents unauthorized user account modification or privilege escalation. |
| **10** | **Server Details Guard** | `app/Services/Servers/DetailsModificationService.php` | Restricts modification of server specifications (CPU, RAM, Disk limits). |

---

## ✦ Access Modes (ID Whitelist)

During setup, select which administrative user ID tier has permission to bypass restrictions:

- **Mode `[0]` - ID 1 Only**: Strict mode. Only primary administrator (User ID `1`) has full access.
- **Mode `[1]` - ID 1 & 2**: Allows primary and secondary administrators (User IDs `1` and `2`).
- **Mode `[2]` - ID 1, 2 & 3**: Allows up to three designated administrator IDs (`1`, `2`, and `3`).

---

## ✦ Prerequisites

- **Operating System**: Linux (Ubuntu, Debian, CentOS, AlmaLinux, Rocky Linux)
- **Pterodactyl Panel**: Installed in default directory (`/var/www/pterodactyl/`)
- **Permissions**: Root (`sudo`) access
- **Dependencies**: `curl` installed (`apt-get install -y curl` or `yum/dnf install -y curl`)

---

## ✦ Installation

Run the one-line installer as `root`:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/install.sh)
```

### Setup Steps
1. Select `[0] Install Anti Intip`.
2. Select your preferred ID whitelist mode (`ID-1`, `ID-1,2`, or `ID-1,2,3`).
3. Select `[0] Install Semua Anti Intip` for all modules, or pick a specific module (`[1]` - `[10]`).
4. Clear panel cache after installation:
   ```bash
   cd /var/www/pterodactyl
   php artisan view:clear
   php artisan config:clear
   php artisan cache:clear
   ```

---

## ✦ Uninstallation / Rollback

To revert patches and restore original panel files:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Qanz4Ever/Pterodactyl-Security/refs/heads/main/install.sh)
```

1. Select `[1] Uninstall Anti Intip`.
2. Select `[0] Uninstall Semua Anti Intip` or choose a specific module to revert.
3. The script restores original files from `.bak`. If `.bak` is missing, it retrieves default clean panel files from the `Uninstall/` directory.
4. Clear panel cache:
   ```bash
   cd /var/www/pterodactyl
   php artisan view:clear
   php artisan config:clear
   php artisan cache:clear
   ```

---

## ✦ How It Works

```
                        [ install.sh ]
                              │
               ┌──────────────┴──────────────┐
               ▼                             ▼
        [ Installer ]                 [ Uninstaller ]
               │                             │
    Checks for patch marker           Checks for .bak
     "Protect By Mfsavana"                   │
        ├── Exists? → Skip            ├── Exists? → Restore .bak
        └── Not found?                └── Missing? → Restore clean
            ├── Backup to .bak                       defaults
            └── Download patch
```

---

## ✦ Disclaimer & Notes

- This tool modifies core Pterodactyl Panel PHP files located in `/var/www/pterodactyl`.
- Always back up your panel directory and database before applying patches or updates.
- Updating Pterodactyl Panel via `git pull` or manual upgrades will overwrite these modifications; simply re-run the installer after updating.
- Menu typography is formatted in ASCII for universal terminal compatibility.

---

## 📜 License

This project uses a **dual-license system**:

### 1. Apache License 2.0 (Primary License)
The general project, documentation, and all non-restricted components are licensed under the **Apache License 2.0**.  
🔗 [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0)

### 2. MFSAVANA SECURITY LICENSE v1.0 (Secondary / Restricted License)
Certain files in this repository are protected and licensed under the **MFSAVANA SECURITY LICENSE v1.0**.

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
