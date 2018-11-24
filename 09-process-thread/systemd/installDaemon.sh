#!/bin/bash
#installDaemon.sh
#This script installs the demo_timer_daemon into the system
#Author: Pascal Zimmermann

#Abort the script if an error happens
set -euo pipefail

#Check if the script is run as root:
if ! [ $(id -u) = 0 ]; then
   echo "This script must be run as root"
   exit 1
fi

#Get the path of this script
SCRIPTPATH=`pwd`/$0
EXECPATH="${SCRIPTPATH%/*}"

#copy files
cp $EXECPATH/bin/demo_timer_daemon /usr/sbin/
cp $EXECPATH/systemd/demo_timer_daemon.service /etc/systemd/system/
cp $EXECPATH/rsyslog/40-demo-timer-daemon.conf /etc/rsyslog.d/
cp $EXECPATH/logrotate/demo_timer /etc/logrotate.d/

echo "Files copied"

systemctl restart rsyslog.service

echo "rsyslog restarted"
