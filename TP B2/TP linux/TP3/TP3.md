# I. Une première VM

🌞 Générer un Vagrantfile
```
vagrant init generic/ubuntu2204 --box-version 4.3.12
```
🌞 Modifier le Vagrantfile
```
Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"
  config.vm.box_version = "4.3.12"
  config.vm.box_check_update = false 
  config.vm.synced_folder ".", "/vagrant", disabled: true
end
```
🌞 Faire joujou avec une VM
```
$ vagrant up
```


# II. Repackaging

🌞 Repackager la box que vous avez choisie
```
vagrant package --output super_box.box
vagrant box add super_box super_box.box
```

🌞 Ecrivez un Vagrantfile qui lance une VM à partir de votre Box
```
Vagrant.configure("2") do |config|
  config.vm.box = "super_box"
  config.vm.box_version = "0"
  config.vm.box_check_update = false 
  config.vm.synced_folder ".", "/vagrant", disabled: true
end
```

# 3. Moult VMs

🌞 Adaptez votre Vagrantfile pour qu'il lance les VMs suivantes (en réutilisant votre box de la partie précédente)

Vagrant.configure("2") do |config|
  config.vm.box = "super_box"
  config.vm.box_version = "0"
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", disabled: true

  (1..3).each do |i|
    vm_name = "node#{i}.tp3.b2"
    vm_ip = "10.3.1.1#{i}"
    vm_ram = "1024"

    config.vm.define vm_name do |vm|
      vm.vm.hostname = vm_name
      vm.vm.network "private_network", type: "static", ip: vm_ip
      vm.vm.provider "virtualbox" do |vb|
        vb.memory = vm_ram
      end
    end
  end
end