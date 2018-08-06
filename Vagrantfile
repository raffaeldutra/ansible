# Rafael Dutra <raffaeldutra@gmail.com>

$pythonInstall = <<-SCRIPT
sudo apt-get update
sudo apt-get install --yes python
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.ssh.insert_key = false

  config.vm.define "jenkins" do |jenkins|
      config.vm.hostname = "jenkins.local"
      jenkins.vm.network :private_network, ip: "172.16.10.100"

      config.vm.provider "virtualbox" do |jenkins_config|
        jenkins_config.name = "jenkins_local"
      end

      jenkins.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
      end
  end

  config.vm.define "sandbox" do |sandbox|
      config.vm.hostname = "sandbox.local"
      sandbox.vm.network :private_network, ip: "172.16.10.2"

      config.vm.provider "virtualbox" do |sandbox_config|
        sandbox_config.name = "sandbox_vm"
      end
  end

  config.vm.provision "ansible-install-python", type: "shell", inline: $pythonInstall

  config.vm.provision "ansible" do |ansible|
      ansible.galaxy_role_file = "ansible/requirements.yml"
      ansible.playbook = "ansible/playbook.yml"
      ansible.groups = {
        "jenkins_local"  => ["jenkins"],
        "sandbox_local"  => ["sandbox"],
      }
  end
end
