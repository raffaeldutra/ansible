$chocolateyPathInstallation = "C:\ProgramData\chocolatey"

if ((Test-Path $chocolateyPathInstallation) -and (Test-Path $chocolateyPathInstallation/choco.exe)) {
    Write-Warning "Chocolatey is already installed"
    exit
}

Set-ExecutionPolicy Bypass -Scope Process -Force; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex