sudo docker run --rm \darjiyo
-v /home/rafael/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
-v $(pwd)/ansible.cfg:/etc/ansible/ansible.cfg \
-v $(pwd):/root \
raffaeldutra/docker-ansible \
ansible-playbook -i /root/hosts /root/playbook.yml -vvv


ssh-copy-id -i /root/.ssh/id_rsa.pub rafael@172.17.0.1
ansible-playbook -i /root/hosts /root/playbook.yml -vvv --ask-become-pass
