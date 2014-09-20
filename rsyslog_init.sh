#!/bin/sh

yes | yum install rsyslog
echo "auth,user.*	/var/log/messages" >> /etc/rsyslog.conf
echo "kern.*		/var/log/kern.log" >> /etc/rsyslog.conf
echo "daemon.*	/var/log/daemon.log" >> /etc/rsyslog.conf
echo "syslog.*	/var/log/syslog" >> /etc/rsyslog.conf
echo "lpr,news,uucp,local0,local1,local2,local3,local4,local5,local6.*	/var/log/unused.log" >> /etc/rsyslog.conf
touch /var/log/kern.log
chown root:root /var/log/kern.log
chmod 0600 /var/log/kern.log
touch /var/log/daemon.log
chown root:root /var/log/daemon.log
chmod 0600 /var/log/daemon.log
touch /var/log/syslog
chown root:root /var/log/syslog
chmod 0600 /var/log/syslog
touch /var/log/unused.log
chown root:root /var/log/unused.log
chmod 0600 /var/log/unused.log