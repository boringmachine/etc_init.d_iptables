#!/bin/sh

yes | yum update
yes | yum install cron
touch /etc/cron.daily/yum.cron
echo '#!/bin/sh' >> /etc/cron.daily/yum.cron
echo '' >> /etc/cron.daily/yum.cron
echo '/usr/bin/yum -R 120 -e 0 -d 0 -y update yum' >> /etc/cron.daily/yum.cron
echo '/usr/bin/yum -R 10 -e 0 -d 0 -y update' >> /etc/cron.daily/yum.cron
chmod +x /etc/cron.daily/yum.cron

yes | yum install perl
perl -p -i -e 's/PRELINKING=yes/PRELINKING=no/g' /etc/sysconfig/prelink
/usr/sbin/prelink -ua
yes | yum install aide
/usr/sbin/aide --init
cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
/usr/sbin/aide --check
echo "00 22 * * * root /usr/sbin/aide --check" >> /etc/crontab

yes | yum install clamav clamav-update
perl -p -i -e 's/Example//g' /etc/freshclam.conf
/usr/bin/freshclam
touch /var/log/clamscan.log
chown root:root /var/log/clamscan.log
chmod 0600 /var/log/clamscan.log
/usr/bin/clamscan -r -l /var/log/clamscan.log /home/
echo "00 22 * * * root /usr/bin/freshclam" >> /etc/crontab
echo "30 22 * * * root /usr/bin/clamscan -r -l /var/log/clamscan.log /home/" >> /etc/crontab

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

yes | yum install lynis
/usr/bin/lynis --check-update
/usr/bin/lynis -Q -c
echo "00 22 * * * root /usr/bin/lynis --check-update" >> /etc/crontab
echo "30 22 * * * root /usr/bin/lynis -Q -c" >> /etc/crontab

yes | yum install git
git clone https://github.com/boringmachine/etc_init.d_iptables
cd etc_init.d_iptables
chmod +x ipt.sh
chmod 755 pfw
./ipt.sh
yes | cp pfw /etc/init.d/
/etc/init.d/pfw start

cd omake
cat /etc/sysctl.conf > /etc/sysctl.conf.old
yes | cp sysctl.conf /etc/sysctl.conf
chown root:root /etc/sysctl.conf
chmod 644 /etc/sysctl.conf
/usr/sbin/sysctl -p /etc/sysctl.conf

yes | yum install audit
chkconfig auditd on
perl -p -i -e 's/ROTATE/keep_logs/g' /etc/audit/auditd.conf
echo "space_left_action = email" >> /etc/audit/auditd.conf
echo "action_mail_acct = root" >> /etc/audit/auditd.conf
echo "admin_space_left_action = halt" >> /etc/audit/auditd.conf
cp /etc/audit/audit.rules /etc/audit/audit.rules.old
yes | cp audit.rules /etc/audit/audit.rules
service auditd restart

cd ..
cd ..
yes | rm etc_init.d_iptables -r

