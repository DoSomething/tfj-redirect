Vagrant.configure("2") do |config|
  ## Choose your base box
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", 1024]
  end

  # SSH Agent forwarding
  config.ssh.forward_agent = true
  
  # Web server (optional)
  config.vm.network :forwarded_port, guest: 80, host: 9999
  
  # Varnish
  # config.vm.network :forwarded_port, guest: 80, host: 8888
  
  # config.vm.provision :shell, :inline => 'cd /vagrant && more install_complete.txt'
end
