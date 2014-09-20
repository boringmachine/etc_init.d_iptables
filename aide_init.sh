#!/bin/sh

yes | yum install aide
/usr/sbin/aide --init
if [ ! -f /var/lib/aide/aide.db.gz ]; then
    cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
fi
/usr/sbin/aide --check
VAL=`cat /etc/crontab | grep aide`
VAL=`echo ${#VAL}`
if [ "${VAL}" == "0" ]; then
    echo "00 22 * * * root /usr/sbin/aide --check" >> /etc/crontab
fi