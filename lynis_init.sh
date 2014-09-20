#!/bin/sh

yes | yum install lynis
/usr/bin/lynis --check-update
/usr/bin/lynis -Q -c
VAL=`cat /etc/crontab | grep lynis`
VAL=`echo ${#VAL}`
if [ "${VAL}" == "0" ]; then
    echo "00 22 * * * root /usr/bin/lynis --check-update" >> /etc/crontab
    echo "30 22 * * * root /usr/bin/lynis -Q -c" >> /etc/crontab
fi