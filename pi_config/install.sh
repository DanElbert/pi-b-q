#! /bin/bash

[ "$UID" -ne 0 ] && echo "You should run this script as a root " && exit 1

apt-get update
apt-get install -y vim

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

curl -sSL https://get.rvm.io | bash -s stable

source /usr/local/rvm/scripts/rvm

rvm install ruby-2.2.1
rvm use 2.2.1

gem install bundler
gem install passenger

