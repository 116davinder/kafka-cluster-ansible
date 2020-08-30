Vagrant.configure("2") do |config|

######################### Cluster Nodes
  cluster_nodes=3

    (1..cluster_nodes).each do |i|
      config.vm.define "kafka-#{i}" do |node|
        node.vm.box = "centos/7"
        node.vm.hostname  = "kafka#{i}"
        node.vm.network :private_network, ip: "192.168.56.10#{i}"
        #node.vm.provision :hosts, :sync_hosts => true
      end
  end
##################### Setting CPU and Memory for All machines
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "750"
    vb.cpus =  1
  end

### Sharing Folder with machines
### is not requried if using linux box
  # config.vm.synced_folder ".", "/home/vagrant/projects",
  #   mount_options: ["dmode=775,fmode=664"]

# SSH config to use your local ssh key for auth instead of username/password
    config.ssh.insert_key = false
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
