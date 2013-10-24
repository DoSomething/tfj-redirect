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
  config.vm.network :forwarded_port, guest: 8888, host: 12121
  
  # Varnish
  config.vm.network :forwarded_port, guest: 6081, host: 12122
  
  ## SALT CONFIG
  ##
  ## For masterless, mount your salt file root
  config.vm.synced_folder "salt/roots/", "/srv/"
  
  ## Use all the defaults:
  config.vm.provision :salt do |salt|
    # Uncomment to see Salt output
    # salt.verbose = true
    salt.minion_config = "salt/minion.conf"
    salt.run_highstate = true
  end
  
  ## config.vm.provision :shell, :inline => 'cd /vagrant && more install_complete.txt'
end
