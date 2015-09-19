#! /bin/bash

[ "$UID" -ne 0 ] && echo "You should run this script as a root " && exit 1

apt-get update
apt-get install -y vim bluez bluez-tools bluez-utils

# Install RVM key
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

# Install RVM
curl -sSL https://get.rvm.io | bash -s stable

# Enable RVM
source /usr/local/rvm/scripts/rvm

# Install Ruby
rvm install ruby-2.2.1
rvm use 2.2.1

# Install bootstrapping gems
gem install bundler

# Install application gems
bundle install

# Copy init files
cp /var/www/pi-b-q/pi_config/harvester_init.sh /var/www/pi-b-q/pi_config/web_init.sh /etc/init.d/
chmod +x /etc/init.d/harvester_init.sh /etc/init.d/web_init.sh

# Create DB
RAILS_ENV=production rake db:create db:migrate

# Compile assets
RAILS_ENV=production rake assets:precompile

# Open permissions
chown -R :www-data /var/www/pi-b-q
chmod -R g+w /var/www/pi-b-q/tmp /var/www/pi-b-q/log

