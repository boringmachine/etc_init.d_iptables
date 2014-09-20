#!/bin/sh

yes | yum update
if [ ! -f /etc/cron.daily/yum.cron ]; then
    touch /etc/cron.daily/yum.cron
    echo '#!/bin/sh' >> /etc/cron.daily/yum.cron
    echo '' >> /etc/cron.daily/yum.cron
    echo '/usr/bin/yum -R 120 -e 0 -d 0 -y update yum' >> /etc/cron.daily/yum.cron
    echo '/usr/bin/yum -R 10 -e 0 -d 0 -y update' >> /etc/cron.daily/yum.cron
    chmod +x /etc/cron.daily/yum.cron
fi