#!/bin/sh

yes | yum install clamav clamav-update perl
perl -p -i -e 's/Example//g' /etc/freshclam.conf
/usr/bin/freshclam
if [ ! -f /var/log/clamscan.log ]; then
    touch /var/log/clamscan.log
    chown root:root /var/log/clamscan.log
    chmod 0600 /var/log/clamscan.log
fi
/usr/bin/clamscan -r -l /var/log/clamscan.log /home/
VAL=`cat /etc/crontab | grep clam`
VAL=`echo ${#VAL}`
if [ "${VAL}" == "0" ]; then
    echo "00 22 * * * root /usr/bin/freshclam" >> /etc/crontab
    echo "30 22 * * * root /usr/bin/clamscan -r -l /var/log/clamscan.log /home/" >> /etc/crontab
fi