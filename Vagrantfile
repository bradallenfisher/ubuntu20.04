# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # centos 7
  config.vm.box = "bradallenfisher/ubuntu16"
  # ip address
  config.vm.network "private_network", ip: "192.168.16.16"
  # host name
  config.vm.hostname = "local.ubuntu16.dev"

  # run script as root
  config.vm.provision "shell",
    path: "stack.sh"

  # virtual box name
  config.vm.provider "virtualbox" do |v|
    v.name = "ubuntu16"
    v.memory = 4096
  end
end
