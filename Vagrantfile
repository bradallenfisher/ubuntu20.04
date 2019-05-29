# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # ubuntu 16
  config.vm.box = "ubuntu/xenial64"
  # ip address
  config.vm.network "private_network", ip: "192.168.16.16"
  # host name
  config.vm.hostname = "local.psufandb.test"
  # synced with NFS
  config.vm.synced_folder "./psufandb", "/var/www/html/psufandb", type: "nfs"
  config.vm.synced_folder "./local_db", "/var/www/local_db", type: "nfs"

  # run script as root
  config.vm.provision "shell",
    path: "vagrant.sh"

  # virtual box name
  config.vm.provider "virtualbox" do |v|
    v.name = "psufandb"
    v.memory = 4096
  end
end
