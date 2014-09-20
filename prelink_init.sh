#!/bin/sh

cat /etc/sysconfig/prelink > /etc/sysconfig/prelink.old
perl -p -i -e 's/PRELINKING=yes/PRELINKING=no/g' /etc/sysconfig/prelink
/usr/sbin/prelink -ua