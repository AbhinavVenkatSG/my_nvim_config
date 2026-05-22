# my_config — Work PC Automated Setup

This file instructs opencode to replicate the exact config and software versions
from the original machine onto this PC.

---

## 1. Prerequisites

- Windows 10/11
- Administrator access (for software installs and symlinks)
- GitHub CLI (`gh`) installed and authenticated
- Git installed

---

## 2. Uninstall Newer Software Versions

Run these to remove existing installations:

```powershell
# Wezterm
winget uninstall "WezTerm" --silent 2>$null
# or check in: Get-WmiObject Win32_Product | Where-Object {$_.Name -like "*WezTerm*"} | ForEach-Object { $_.Uninstall() }

# Yazi
winget uninstall "Yazi" --silent 2>$null

# GlazeWM
winget uninstall "GlazeWM" --silent 2>$null

# Yasb — check Add/Remove Programs; if installed as standalone EXE, delete the folder:
Remove-Item -Recurse -Force "C:\Program Files\YASB" -ErrorAction SilentlyContinue

# Neovim — if installed via portable zip, just delete the folder:
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\nvim" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "C:\tools\nvim" -ErrorAction SilentlyContinue
```

---

## 3. Install Correct Software Versions

Create a tools directory:
```powershell
New-Item -ItemType Directory -Force -Path "C:\tools"
```

### 3a. Neovim v0.11.4

```powershell
$url = "https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-win64.zip"
$zip = "$env:TEMP\nvim-win64.zip"
Invoke-WebRequest -Uri $url -OutFile $zip
Expand-Archive -Path $zip -DestinationPath "C:\tools" -Force
Rename-Item "C:\tools\nvim-win64" "C:\tools\nvim" -Force

# Add to PATH (system-wide)
[Environment]::SetEnvironmentVariable("Path", "$env:Path;C:\tools\nvim\bin", "Machine")
```

### 3b. Wezterm 20260331-040028-577474d8

```powershell
$url = "https://github.com/wezterm/wezterm/releases/download/20260331-040028-577474d8/WezTerm-20260331-040028-577474d8-setup-20260331-040028-577474d8.msi"
$msi = "$env:TEMP\wezterm.msi"
Invoke-WebRequest -Uri $url -OutFile $msi
Start-Process msiexec.exe -ArgumentList "/i `"$msi`" /qn" -Wait
```

### 3c. Yazi 25.5.31

```powershell
$url = "https://github.com/sxyazi/yazi/releases/download/v25.5.31/yazi-x86_64-pc-windows-msvc.zip"
$zip = "$env:TEMP\yazi.zip"
Invoke-WebRequest -Uri $url -OutFile $zip
Expand-Archive -Path $zip -DestinationPath "C:\tools" -Force
# It extracts into a folder like yazi-x86_64-pc-windows-msvc
$extracted = Get-ChildItem "C:\tools" -Directory | Where-Object { $_.Name -like "yazi-*" } | Select-Object -First 1
if ($extracted) { Rename-Item $extracted.FullName "C:\tools\yazi" -Force }

# Add to PATH
[Environment]::SetEnvironmentVariable("Path", "$env:Path;C:\tools\yazi", "Machine")
```

### 3d. GlazeWM (latest)

```powershell
# Download from official site
$url = "https://github.com/glzr-io/glazewm/releases/latest/download/GlazeWM.exe"
$exe = "$env:TEMP\GlazeWM.exe"
Invoke-WebRequest -Uri $url -OutFile $exe
Start-Process $exe -ArgumentList "/S" -Wait
```

### 3e. Yasb (latest)

```powershell
# Download from GitHub releases
$url = "https://github.com/denBot/yasb/releases/latest/download/YASB-Setup.exe"
$exe = "$env:TEMP\YASB-Setup.exe"
Invoke-WebRequest -Uri $url -OutFile $exe
Start-Process $exe -ArgumentList "/S" -Wait
```

---

## 4. Clone the Config Repo

```powershell
$repoDir = "C:\tools\my_config"
if (Test-Path $repoDir) { Remove-Item -Recurse -Force $repoDir }
git clone https://github.com/AbhinavVenkatSG/my_config.git $repoDir
```

---

## 5. Backup Existing Configs

```powershell
$backupSuffix = ".bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
$backupItems = @(
    "$env:USERPROFILE\.config\nvim"
    "$env:USERPROFILE\.config\yazi"
    "$env:USERPROFILE\.config\yasb"
    "$env:USERPROFILE\.glzr\glazewm"
    "$env:USERPROFILE\.wezterm.lua"
)
foreach ($item in $backupItems) {
    if (Test-Path $item) {
        Rename-Item -Path $item -NewName "$item$backupSuffix" -Force
        Write-Output "Backed up: $item -> $item$backupSuffix"
    }
}
```

---

## 6. Create Symlinks (Junctions)

Configs are deployed as directory junctions so a `git pull` in the repo dir
instantly updates all configs.

```powershell
$repoDir = "C:\tools\my_config"

# Ensure parent directories exist
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.glzr"

# Create junctions for directories
New-Item -ItemType Junction -Path "$env:USERPROFILE\.config\nvim"  -Target "$repoDir\nvim"  -Force
New-Item -ItemType Junction -Path "$env:USERPROFILE\.config\yazi"  -Target "$repoDir\yazi"  -Force
New-Item -ItemType Junction -Path "$env:USERPROFILE\.config\yasb"  -Target "$repoDir\yasb"  -Force
New-Item -ItemType Junction -Path "$env:USERPROFILE\.glzr\glazewm" -Target "$repoDir\glazewm" -Force

# Symbolic link for the single wezterm file
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.wezterm.lua" -Target "$repoDir\wezterm.lua" -Force
```

---

## 7. Install Neovim Plugins

```powershell
# First launch to let Lazy install plugins
nvim --headless "+Lazy! sync" +qa
```

If plugins fail to install, open nvim interactively and run `:Lazy sync`.

---

## 8. Verification

| Tool | Check Command | Expected |
|------|--------------|----------|
| Neovim | `nvim --version` | v0.11.4 |
| Wezterm | `wezterm --version` | 20260331-040028-577474d8 |
| Yazi | `yazi --version` | 25.5.31 |
| GlazeWM | `glazewm --version` | latest |
| Configs | `cmd /c dir /a:J "%USERPROFILE%\.config\nvim"` | Shows `<JUNCTION>` |

Also verify that `~/.config/nvim/init.lua` is the same file as `C:\tools\my_config\nvim\init.lua`
(they should be identical since the junction points there).

---

## 9. Future Updates

On this work PC, to pull the latest configs from the original machine:

```powershell
cd C:\tools\my_config
git pull
```

No further steps needed — the junctions make changes live immediately.

On the original machine, whenever you change a config, commit and push:

```powershell
cd C:\tools\my_config   # or wherever the repo is cloned
git add -A
git commit -m "Update configs"
git push
```

Then on the work PC, run `git pull` to sync.
