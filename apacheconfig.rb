#This is to be used in order to create new config file in /etc/apache2/sites-available
#file should end with .conf extension
<VirtualHost *:80>
  RewriteEngine On
  RewriteCond %{HTTPS} off
  RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}
 </VirtualHost>
 <VirtualHost *:443>
  SSLEngine on
  SSLProtocol All -SSLv2 -SSLv3
  SSLCertificateFile /etc/apache2/ssl/apache.crt
  SSLCertificateKeyFile /etc/apache2/ssl/apache.key
 Redirect temp / /
  <Location />
      ProxyPass http://0.0.0.0:8000/
      ProxyPassReverse http://0.0.0.0:8000/
  </Location>
</VirtualHost>

#Then
sudo a2dissite 000-default.conf
sudo a2ensite "name-of-new-conf-file"

#Apache will say:
#To activate the new configuration, you need to run:
  #service apache2 reload

#But first:
sudo a2enmod rewrite
sudo a2enmod ssl
sudo a2enmod proxy # the main proxy module Apache module for redirecting connections; it allows Apache to act as a gateway to the underlying application servers
sudo a2enmod proxy_http # which adds support for proxying HTTP connections.
sudo a2enmod proxy_balancer #which add load balancing features for multiple backend servers.
sudo a2enmod lbmethod_byrequests #which add load balancing features for multiple backend servers.

#Then:
sudo mkdir /etc/apache2/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt

#Then
sudo service apache2 reload


#Enjoy