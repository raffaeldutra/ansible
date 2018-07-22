# Rafael Dutra <raffaeldutra@gmail.com>

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.define "jenkins" do |jenkins|
      config.vm.hostname = "jenkins.local"
      jenkins.vm.network :private_network, ip: "172.16.10.100"

      config.vm.provider "virtualbox" do |jenkins_config|
        jenkins_config.name = "my_vm"
      end
  end

  config.vm.provision "ansible" do |ansible|
      ansible.galaxy_role_file = "ansible/requirements.yml"
      ansible.playbook = "ansible/playbook.yml"
      ansible.groups = {
        "jenkins_server" => ["jenkins"],
      }
  end
end
