# SenShi-vagrant
Easy setup anyone can make trough

## Quick vagrant usage guide:
```
**vagrant up** - Starts the VM [called from folder with your *Vagrantfile*]
**vagrant ssh** - Establish 'remote' access to your VM
**vagrant halt** - Shutdowns VM
**vagrant destroy** - Removes the VM (delete all files created by `vagrant up`)
```


### How to setup SenShi using vagrant
* Install **vagrant** and **virtualbox** or **vmware**
* Clone this repository somewhere & cd into it
* Edit Vagrant file @ `config.vm.synced_folder` to share your music directory
* Run vagrant up and wait for everything to setup **(this will take a while)**
* When everything finishes, `vagrant ssh`
* Setup database for SenShi with `createDatabase`
* Finaly run `senshi`

**TLDR:**
```
git clone https://github.com/Senketsu/SenShi-vagrant`
cd SenShi-vagrant
```
Edit Vagrantfile at line `config.vm.synced_folder` to share your music directory
```
vagrant up
vagrant ssh
createDatabase
senshi
```



### How do I 'xyz':
---------------------
**Why can't i connect to MySQL from the host ?**
* In this vagrant, MySQL is configured to allow only local connections, i.e: on 'localhost'
* If you want to allow remote connections, edit mysql config and comment out 'skip-networking'


**How to create new MySQL user for SenShi:**
* This will create new MySQL user 'senshi' with 'mypassword' and gives him full rights to 'xxx' database
`vagrant ssh` into your virtual machine
```
mysql -u root -p
CREATE USER 'senshi'@'localhost' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON xxx.* TO 'senshi'@'localhost' WITH GRANT OPTION;
exit
```
* Remember you will need to change SenShi's config file to your new user/pass (if you want to use it that is)
* Either use *nano* - `nano ~/Senshi/conf/Manager_DB.ini`
* Or simply remove the config and run SenShi (`rm ~/Senshi/conf/Manager_DB.ini`)

### Known Issues:
---------------------
**1st time Re-compiling SenShi `Error: cannot open 'ndbex/db_mysql_ex'`**
* After provisioning, if you try to recompile SenShi, **nimble**'s package *ndbex* is missing. (whole nimble folder)
* You need to manualy reinstall it with `nimble install ndbex`
*At this moment, no idea why this happens*
