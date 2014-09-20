#!/bin/sh

cat /etc/sysctl.conf > /etc/sysctl.conf.old
yes | cp sysctl.conf /etc/sysctl.conf
chown root:root /etc/sysctl.conf
chmod 644 /etc/sysctl.conf
/usr/sbin/sysctl -p /etc/sysctl.conf