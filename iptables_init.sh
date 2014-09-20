#!/bin/sh

chmod +x ipt.sh
chmod 755 pfw
./ipt.sh
yes | cp pfw /etc/init.d/
chkconfig --add pfw
/etc/init.d/pfw start