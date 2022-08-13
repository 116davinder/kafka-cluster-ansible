Vagrant.configure("2") do |config|

# Cluster Nodes
  cluster_nodes=3

    (1..cluster_nodes).each do |i|
      config.vm.define "kafka-#{i}" do |node|
        node.vm.box = "ubuntu/focal64"
        node.vm.hostname  = "kafka#{i}"
        node.vm.network :private_network, ip: "192.168.56.10#{i}"
        # expose JMX port
        node.vm.network "forwarded_port", guest: 9999, host: "1000#{i}", protocol: "tcp"
        # node.vm.provision :hosts, :sync_hosts => true
      end
  end
  # Setting CPU and Memory for All machines
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "1024"
    vb.cpus =  1
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ] # used for wsl2
  end

# SSH config to use your local ssh key for auth instead of username/password
  config.ssh.insert_key = false
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
end