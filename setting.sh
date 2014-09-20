#!/bin/sh

DATE=`date -d now +%Y%M%d%H%M%S`
DIR=working_dir_${DATE}
mkdir ${DIR}
cd ${DIR}
yes | yum install git
git clone https://github.com/boringmachine/etc_init.d_iptables
cd etc_init.d_iptables

./yum_init.sh &
./prelink_init.sh &
./aide_init.sh &
./clamav_init.sh &
./rsyslog_init.sh &
./lynis_init.sh & 
./iptables_init.sh &
./sysctl_init.sh &
./audit.sh &

cd ..
yes | rm -r ${DIR}

