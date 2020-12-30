# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # ubuntu 20
  config.vm.box = "bento/ubuntu-20.04"
  # ip address
  config.vm.network "private_network", ip: "192.168.20.20"
  # host name
  config.vm.hostname = "fws.test"

  # run script as root	
  config.vm.provision "shell",	
    path: "start.sh"
  
  # virtual box name
  config.vm.provider "virtualbox" do |v|
    v.name = "fws"
    v.memory = 4096
  end
end
