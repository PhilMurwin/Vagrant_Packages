#!/usr/bin/env bash

########################################################
# Installing Dependencies
########################################################
apt-get update								# Update the apt-get package list
apt-get -y install openjdk-7-jre-headless	# Get the Java JDK

########################################################
# Get TeamCity tar gzip on file system
########################################################
cd /tmp

TCPath="/vagrant/Software/" 
TCFile="TeamCity-8.0.3.tar.gz"

# Try copying the file first, if it doesn't exist then download it
if [ -f "$TCPath$TCFile" ]
then
	cp "$TCPath$TCFile" ./
else
	wget "http://download.jetbrains.com/teamcity/$TCFile"
fi

########################################################
# Untar/gzip TeamCity
########################################################
chmod 777 "/tmp/$TCFile" # Make sure we can manipulate the file as needed
cd /opt					 # Change to the directory we're going to unzip to
tar -zxvf "/tmp/$TCFile" # Unzip the TeamCity Package
rm "/tmp/$TCFile"		 # Get rid of the zip file (no longer needed)

########################################################
# Start TeamCity Server
########################################################
/opt/TeamCity/bin/teamcity-server.sh start
