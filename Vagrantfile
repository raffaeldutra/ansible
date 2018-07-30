# Rafael Dutra <raffaeldutra@gmail.com>

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.ssh.insert_key = false
  
  config.vm.define "jenkins" do |jenkins|
      config.vm.hostname = "jenkins.local"
      jenkins.vm.network :private_network, ip: "172.16.10.100"

      config.vm.provider "virtualbox" do |jenkins_config|
        jenkins_config.name = "my_vm"
      end
  end

  config.vm.define "sandbox" do |sandbox|
      config.vm.hostname = "sandbox.local"
      sandbox.vm.network :private_network, ip: "172.16.10.2"

      config.vm.provider "virtualbox" do |sandbox_config|
        sandbox_config.name = "sandbox_vm"
      end
  end

  config.vm.provision "ansible" do |ansible|
      ansible.galaxy_role_file = "ansible/requirements.yml"
      ansible.playbook = "ansible/playbook.yml"
      ansible.groups = {
        "jenkins_server" => ["jenkins"],
        "sandbox_local"  => ["sandbox"],
      }
  end
end
