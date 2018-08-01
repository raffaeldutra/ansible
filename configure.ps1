#Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force

if ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State -ne 'Enabled') {
    try {
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
    } catch {
        Write-Warning 'Unable to install the WSL feature!'
    }
} else {
    Write-Warning 'Windows subsystem for Linux optional feature already installed!'
}

$InstalledWSLDistros = @((Get-ChildItem 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss' -ErrorAction:SilentlyContinue | ForEach-Object { Get-ItemProperty $_.pspath }).DistributionName)
$InstallPath = 'C:\ubuntu'
$WSLExe = Join-Path $InstallPath ubuntu
$WSLDownloadPath = "https://aka.ms/wsl-ubuntu-1604"
$Distro = 'ubuntu'

if ($InstalledWSLDistros -notcontains "ubuntu") {
    Write-Output "WSL distro Ubuntu is not found to be installed on this system, attempting to download and install it now..."

    if (-not (Test-Path $WSLDownloadPath)) {
        Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile C:\ubuntu.zip -UseBasicParsing
    } else {
        Write-Warning "The $Distro zip file appears to already be downloaded."
    }

    Expand-Archive C:\ubuntu.zip C:\ubuntu -Force

    if (Test-Path $WSLExe) {
        Write-Output "Starting $WSLExe"
        Start-Proc -Exe $WSLExe -waitforexit
    } else {
        Write-Warning "$WSLExe was not found for whatever reason"
    }
} else {
    Write-Warning "Found $Distro is already installed on this system. Enter it simply by typing bash.exe"
}

# Install Chocolatey
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
try {
    . ("$ScriptDirectory\scripts\windows\environment.ps1")
}
catch {
    Write-Host "Error while loading supporting PowerShell Scripts" 
}