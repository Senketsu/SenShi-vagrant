#!/usr/bin/env bash
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Provision shell script for SenShi
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo "--# 1 / 3 #-- Installing packages for ~SenShi~"
sudo pacman -Syu --noconfirm
sudo pacman -S mariadb mariadb-clients libmariadbclient --needed --noconfirm
sudo pacman -S icecast libshout taglib --needed --noconfirm
sudo pacman -S nim nimble git --needed --noconfirm
nimble update
nimble install ndbex -y
echo "--# 2 / 3 #-- Setting up enviroment"
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @ Recommended to change passwords in config located @ '/etc/icecast.xml'    @
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
sudo systemctl start icecast
sudo systemctl enable icecast
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @ Setup MySQL server (MariaDB) - Recommended to change your root password   @
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo cp /vagrant/data/my.cnf /etc/mysql/my.cnf
sudo systemctl start mysqld.service
sudo systemctl enable mysqld.service
mysqladmin -u root password 'changeme'
mysqladmin -u root -h archbox password 'changeme'
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @              If you want Apache server with php provisioned               @
# @           uncomment the line below and also the services                  @
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# sudo pacman -S apache php php-apache --needed --noconfirm
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @ Uncomment to enable the template website @ 'localhost:8080' [not finished]@
# @   (This will rewrite Apache's default config files)                       @
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# sudo cp /vagrant/data/httpd.conf /etc/httpd/conf/httpd.conf
# sudo cp /vagrant/data/httpd-vhosts.conf /etc/httpd/conf/extra/httpd-vhosts.conf
# sudo cp /vagrant/data/php.ini /etc/php/php.ini
# sudo mkdir /var/log/php
# sudo chown http /var/log/php
# sudo ln -fs /vagrant/web /srv/http
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @ Uncomment this block to start & enable the Apache service                 @
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# sudo systemctl start httpd.service
# sudo systemctl enable httpd.service
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo "--# 3 / 3 #-- Preparing SenShi"
cd /vagrant
git clone https://github.com/Senketsu/SenShi
cd SenShi/src
nim c --threads:on senshi.nim
nim c -d:release ./other/createDatabase.nim
sudo ln -s '/vagrant/SenShi/src/other/createDatabase' '/usr/local/bin/createDatabase'
sudo ln -s '/vagrant/SenShi/src/senshi' '/usr/local/bin/senshi'
printf "\033[1;36m[Info]:\033[0m All done !\n"
printf "\033[1;36m[Info]:\033[0m Run \033[1;33m'createDatabase'\033[0m to create new MySql DB for SenShi \n"
printf "\033[1;31m*Warning*\033[0m Don't forget to change all passwords! (icecast,mysql,etc..)\n"

