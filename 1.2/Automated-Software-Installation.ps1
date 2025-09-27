# Automatic software installation script for Windows

# Disables the confirmation request for Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force

# Chocolatey installation
Write-Host "Downloading Chocolatey..." -ForegroundColor Green   
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
refreshenv

# Installing software using Chocolatey

# The list of software that can be installed via Chocolatey
$chocoPackages = @(
    "vscode",
    "docker-desktop",
    "pycharm-community",
    "git",
    "github-desktop",
    "maxima",
    "gimp",
    "python",
    "msys2",
    "miktex",
    "texstudio",
    "anaconda3",
    "far",
    "sumatrapdf",
    "googlechrome",
    "firefox",
    "7zip"
)

Write-Host "Downloading Software through Chocolatey..." -ForegroundColor Green
foreach ($package in $chocoPackages) {
    Write-Host "Downloading $package..." -ForegroundColor Yellow
    choco install $package -y --no-progress
}

# Installing extensions for VS Code
Write-Host "Downloading extensions for VS Code..." -ForegroundColor Green

# The list of extensions for VS Code
$vscodeExtensions = @(
    "ms-python.python",
    "ms-vscode.cpptools",
    "ms-azuretools.vscode-docker",
    "ms-vscode.PowerShell",
    "yzhang.markdown-all-in-one",
    "bungcip.better-toml",
    "bung87.rust-analyzer",
    "julialang.language-julia"
)
foreach ($extension in $vscodeExtensions) {
    Write-Host "Downloading $extension extension..." -ForegroundColor Yellow
    code --install-extension $extension --force
}

# Installing software that is not available in Chocolatey (via direct links)

Write-Host "Installing software via direct links..." -ForegroundColor Green

# Julia installation
Write-Host "Downloading Julia..." -ForegroundColor Yellow
$juliaUrl = "https://julialang-s3.julialang.org/bin/winnt/x64/1.10/julia-1.10.3-win64.exe"
$juliaInstaller = "$env:TEMP\julia-installer.exe"
Invoke-WebRequest -Uri $juliaUrl -OutFile $juliaInstaller
Start-Process -FilePath $juliaInstaller -Args "/S" -Wait -Verb RunAs

# Rust installation
Write-Host "Downloading Rust..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "https://win.rustup.rs/x86_64" -OutFile "$env:TEMP\rustup-init.exe"
Start-Process -FilePath "$env:TEMP\rustup-init.exe" -Args "-y" -Wait

# Zettlr installation
Write-Host "Downloading Zettlr..." -ForegroundColor Yellow
$zettlrUrl = "https://github.com/Zettlr/Zettlr/releases/download/v3.0.4/Zettlr-Windows-x64-3.0.4.exe"
$zettlrInstaller = "$env:TEMP\zettlr-installer.exe"
Invoke-WebRequest -Uri $zettlrUrl -OutFile $zettlrInstaller
Start-Process -FilePath $zettlrInstaller -Args "/S" -Wait -Verb RunAs

# Flameshot installation
Write-Host "Downloading Flameshot..." -ForegroundColor Yellow
$flameshotUrl = "https://github.com/flameshot-org/flameshot/releases/download/v13.1.1/flameshot-13.1.1-win64-installer.exe"
$flameshotInstaller = "$env:TEMP\flameshot-installer.exe"
Invoke-WebRequest -Uri $flameshotUrl -OutFile $flameshotInstaller
Start-Process -FilePath $flameshotInstaller -Args "/S" -Wait -Verb RunAs

# WSL2 and Ubuntu 22.04 installation
Write-Host "Downloading WSL2 and Ubuntu 22.04..." -ForegroundColor Yellow
wsl --install -d Ubuntu-22.04 --no-distribution-code

Write-Host "Installation completed! Please restart your computer to activate WSL2." -ForegroundColor Green
