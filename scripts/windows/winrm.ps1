#http://www.hurryupandwait.io/blog/understanding-and-troubleshooting-winrm-connection-and-authentication-a-thrill-seekers-guide-to-adventure
# Important: your ethernete connection MUST be in private mode

netsh advfirewall firewall add rule name="WinRM-HTTPS" dir=in localport=5986 protocol=TCP action=allow

$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file

# current listeners
# Run: winrm enumerate winrm/config/Listener
# Then copy the CertificateThumbprint and past it in the $value_set

# Remove all listeners
Remove-Item -Path WSMan:\localhost\Listener\* -Recurse -Force

# Only remove listeners that are run over HTTPS
Get-ChildItem -Path WSMan:\localhost\Listener | Where-Object { $_.Keys -contains "Transport=HTTPS" } | Remove-Item -Recurse -Force  

# https://support.microsoft.com/en-us/help/2019527/how-to-configure-winrm-for-https
# Configure it: winrm quickconfig -transport:https

$selector_set = @{
    Address = "*"
    Transport = "HTTPS"
}

$value_set = @{
    CertificateThumbprint = "7C0E749F800903BD3D3F6E59D3AA72C3C0349FF4"
}

New-WSManInstance -ResourceURI "winrm/config/Listener" -SelectorSet $selector_set -ValueSet $value_set