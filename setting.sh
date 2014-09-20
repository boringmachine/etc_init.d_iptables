#!/bin/sh

DATE=`date -d now +%Y%M%d%H%M%S`
touch ${DATE}
echo ${DATE} > ${DATE}
DIR=`md5sum ${DATE} | awk  '{print $1;}'`
mkdir ${DIR}
rm ${DATE}
cd ${DIR}
yes | yum install git perl
git clone https://github.com/boringmachine/etc_init.d_iptables
cd etc_init.d_iptables

./yum_init.sh
./prelink_init.sh
./aide_init.sh
./clamav_init.sh
#./rsyslog_init.sh
./lynis_init.sh
./iptables_init.sh
./sysctl_init.sh
./audit.sh

cd ..
yes | rm -r ${DIR}

