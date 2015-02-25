# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "chef/centos-7.0"

  # #########################
  # Inbound HTTP
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  
  # Inbound HTTPS
  config.vm.network "forwarded_port", guest: 8443, host: 8443
  
  # Elasticsearch
  config.vm.network "forwarded_port", guest: 9200, host: 9200
  
  # Kibana
  config.vm.network "forwarded_port", guest: 5601, host: 5601
  # #########################

  config.vm.synced_folder "../", "/home/vagrant/code", create: true

  config.vm.provision "shell", 
    privileged: false, 
    path: "provision.sh"

  # Note: necessary to always run provisioning script, due to fact that
  # Docker service has to be restarted *after*  synced folders are mounted
  # in order to mount those same volumes into a Docker container:
  # https://github.com/docker/docker/issues/4213
  config.vm.provision :shell, 
    privileged: true,
    run: "always",
    inline: "systemctl daemon-reload && systemctl restart docker"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

end