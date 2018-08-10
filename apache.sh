#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
echo "Updating System"
sudo apt-get -y update
sudo apt-get -y upgrade
echo "Installing Apache2 Web Server"
sudo apt-get install -y apache2
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get -y update
sudo rm /var/www/html/index.html
sudo chown www-data: -R /var/www/html
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_ajp
sudo a2enmod rewrite
sudo a2enmod deflate
sudo a2enmod headers
sudo a2enmod proxy_balancer
sudo a2enmod proxy_connect
sudo a2enmod proxy_html
sudo a2enmod ssl
sudo git clone https://github.com/ivanov-vision/apache2script
sudo mv apache2script/000-default2.conf /etc/apache2/sites-available/
sudo a2ensite 000-default2.conf
sudo a2dissite 000-default.conf
sudo mkdir /etc/apache2/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt<<EOF
$UK
$LO
$LO
$CV
$IT
$(curl -4 icanhazip.com)
$email
EOF
sudo apt-get install -y php7.1 php7.1-common
sudo apt-get install -y php7.1-curl php7.1-xml php7.1-zip php7.1-gd php7.1-mysql php7.1-mbstring
sudo service apache2 restart
sudo git clone 'URL' /var/www/html
sudo sh apache2script/composer.sh
