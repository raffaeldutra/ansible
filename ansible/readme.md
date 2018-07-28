# Windows 10 enviroment

## Installing Chocolatey

## Installing on Ansible on Windows 10

First, find the build number for your system

```bash
systeminfo | Select-String "^OS Name","^OS Version"
```

If you have the build version 16215, run the command below

Open PowerShell as Administrator and run:

```bash
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

In case the earlier versios, follow this:
To install Windows Subsystem Linux, you have to enable Developer Mode in Settings App. So open Settings > Update & Security > For Developer > Developer Mode & select it to enable.

or you may enable Developer Mode with registry tweak. Make registry script (.reg) with the following::


```bash
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock]
"AllowAllTrustedApps"=dword:1
"AllowDevelopmentWithoutDevLicense"=dword:1
```


# Docker usage

```bash
sudo docker run --rm \darjiyo
-v /home/rafael/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
-v $(pwd)/ansible.cfg:/etc/ansible/ansible.cfg \
-v $(pwd):/root \
raffaeldutra/docker-ansible \
ansible-playbook -i /root/hosts /root/playbook.yml -vvv --ask-become-pass
```

# Linux Environment
ssh-copy-id -i /root/.ssh/id_rsa.pub rafael@172.17.0.1

## Hand installation

Install the required roles
```bash
ansible-galaxy install -r requirements.yml
```

Copy the public key to authorized_users
```bash
 ssh-copy-id rafael@localhost
```


Run it
```bash
ansible-playbook -i hosts playbook.yml -vvv --ask-become-pass
```
