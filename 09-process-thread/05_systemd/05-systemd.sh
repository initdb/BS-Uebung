#!/bin/bash

#####################################################
# 9.5 systemd                                       #
#####################################################

sudo ./installDaemon.sh

# start the daemon
service demo_timer_daemon start

# check if the daemon is running
service demo_timer_daemon status

# stop the daemon
service demo_timer_daemon stop

# activate the daemon for the multi-user.target
# check .service file
systemctl enable demo_timer_daemon

# reboot -> service demo_timer_daemon status
# deactivate daemon
systemctl disable demo_timer_daemon