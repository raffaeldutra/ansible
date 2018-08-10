# Running ansible by Hand

```bash
ansible-playbook --private-key=~/.vagrant.d/insecure_private_key -u vagrant -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory playbook.yml
```

Link for full documentation:
[https://docs.ansible.com/ansible/2.5/scenario_guides/guide_vagrant.html](https://docs.ansible.com/ansible/2.5/scenario_guides/guide_vagrant.html)

# Windows 10 build 16215 and higher

First, find the build number for your system

```bash
systeminfo | Select-String "^OS Name","^OS Version"
```

If you have the build version 16215, run the command below

Open PowerShell as Administrator and run:

```bash
./configure.ps1
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

### Installing requirements.yaml
```bash
ansible-galaxy install -r requirements.yml
```

### Running in localhost
```bash
ansible-playbook -i localhost_local desktop.yml -vvv --ask-become-pass
```

Run it
```bash
ansible-playbook -i hosts playbook.yml -vvv --ask-become-pass
```
