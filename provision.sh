#!/bin/bash

set -e
set -x



echo "provisioning!"

# TODO your code here
# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions

sudo apt-get update -y
sudo apt-get install python3-pip python3-dev nginx -y
sudo pip3 install virtualenv

# Set-up project environment
if [ -d "/home/vagrant/myproject" ];
then
   echo "myproject exist."
else
   echo "Creating myproject ..."

   mkdir  /home/vagrant/myproject
   cd /home/vagrant/myproject

   virtualenv myprojectenv

   source myprojectenv/bin/activate

   pip install gunicorn flask

   deactivate

   #Create a systemd unit file
   sudo cp /vagrant/gunicorn.config  /etc/systemd/system/myproject.service

   #Update server settings
   sudo cp /vagrant/server-defaults.txt  /etc/nginx/sites-available/default
   sudo cp /vagrant/server-myproject.txt  /etc/nginx/sites-available/myproject

   sudo ufw allow 'Nginx Full'

   sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled

   sudo chown -R vagrant myproject
fi


# Update project file
cp /vagrant/hello.py /home/vagrant/myproject/hello.py
cp /vagrant/wsgi.py /home/vagrant/myproject/wsgi.py

# Enable wsgi settings
sudo systemctl start myproject
sudo systemctl enable myproject

# Enable nginx server settings
sudo systemctl restart nginx


# Install virtualenv
echo "***** provisioning complete! ***** "
