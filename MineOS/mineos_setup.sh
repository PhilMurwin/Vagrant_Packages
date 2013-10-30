#!/usr/bin/env bash

########################################################
# Installing Dependencies
########################################################
apt-get update
apt-get -y install screen python-cherrypy3 rdiff-backup git openjdk-7-jre-headless

########################################################
# Installing MineOS Scripts
########################################################
mkdir -p /usr/games
cd /usr/games

git clone --depth 1 https://github.com/hexparrot/mineos minecraft

cd minecraft
git config core.filemode false

chmod +x server.py mineos_console.py generate-sslcert.sh

########################################################
# Running MineOS Web Service
########################################################
# Have web interface start
cp /usr/games/minecraft/init/mineos /etc/init.d/
chmod 744 /etc/init.d/mineos
update-rc.d mineos defaults

# Start each server marked start server at boot
cp /usr/games/minecraft/init/minecraft /etc/init.d/
chmod 744 /etc/init.d/minecraft
update-rc.d minecraft defaults

# Copy default mineos.conf
cp /usr/games/minecraft/mineos.conf /etc/

# Generate self signed cert for HTTPS functionality
cd /usr/games/minecraft
./generate-sslcert.sh

# Start the web ui
service mineos start