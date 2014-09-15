# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hadoop-base"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"

  config.vm.boot_timeout = 60
  config.vm.synced_folder "data", "/srv/data", type:"nfs"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--cpus", "1", "--memory", "512"]
  end

  config.vm.define :datanode1 do |datanode1|
    datanode1.vm.network "private_network", ip: "192.100.100.11"
    datanode1.vm.hostname = "datanode1.local"

    config.vm.provision :puppet do |puppet|
      puppet.manifest_file = "datanode.pp"
      puppet.module_path = "modules"
    end
  end

  config.vm.define :datanode2 do |datanode2|
    datanode2.vm.network "private_network", ip: "192.100.100.12"
    datanode2.vm.hostname = "datanode2.local"

    config.vm.provision :puppet do |puppet|
      puppet.manifest_file = "datanode.pp"
      puppet.module_path = "modules"
    end
  end

  config.vm.define :masternode, primary: true do |masternode|
    masternode.vm.network "private_network", ip: "192.100.100.10"
    masternode.vm.hostname = "masternode.local"

    config.vm.provision :puppet do |puppet|
      puppet.manifest_file = "masternode.pp"
      puppet.module_path = "modules"
    end
  end

end
