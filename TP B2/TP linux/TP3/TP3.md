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

[ Vagrantfile 3A](/TP%20B2/TP%20linux/TP3/partie1/Vagrantfile-3A)

[ Vagrantfile 3B](/TP%20B2/TP%20linux/TP3/partie2/Vagrantfile-3B)