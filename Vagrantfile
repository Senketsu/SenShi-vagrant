# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "bugyt/archlinux"

  # Port forwarding
  # config.vm.network "forwarded_port", guest: 80, host: 8080   # Http
  config.vm.network "forwarded_port", guest: 3306, host: 9500 # MySQL
  config.vm.network "forwarded_port", guest: 8000, host: 8888 # IceCast

  # Here you set your shared Music folder e.g:
  # EXAMPLE: config.vm.synced_folder "/source", "/destination"
  config.vm.synced_folder "/home/senketsu/Music", "/MusicHost"

  # Provisions
  config.vm.provision :shell, path: "bootstrap.sh"

end
