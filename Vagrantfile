# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.ssh.forward_agent = true
  config.vm.network 'forwarded_port', guest: 9292, host: 9292
  config.vm.network 'forwarded_port', guest: 9393, host: 9393

  config.vm.provision "ansible" do |ansible|
	  ansible.playbook = "provisioning/playbook.yml"
	  #ansible.inventory_path = "provisioning/inventory"
	  ansible.sudo = true
  end
end
