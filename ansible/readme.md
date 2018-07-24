## Docker usage

```bash
sudo docker run --rm \darjiyo
-v /home/rafael/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
-v $(pwd)/ansible.cfg:/etc/ansible/ansible.cfg \
-v $(pwd):/root \
raffaeldutra/docker-ansible \
ansible-playbook -i /root/hosts /root/playbook.yml -vvv --ask-become-pass
```

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
