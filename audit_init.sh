yes | yum install audit
chkconfig auditd on
perl -p -i -e 's/ROTATE/keep_logs/g' /etc/audit/auditd.conf
yes | cp /etc/audit/audit.rules /etc/audit/audit.rules.old
yes | cp audit.rules /etc/audit/audit.rules
service auditd restart