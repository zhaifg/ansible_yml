#!/bin/bash

flag=`fdisk -l | sed -n '/dev\/xvdb1/p'`
flag2=`fdisk -l | sed -n '/dev\/xvdb/p'`

if [[ $flag -eq "" ]];then
if [[ $flag2 -ne "" ]];then
   fdisk /dev/xvdb << EOF
n
p
1
t
1
8e


wq
EOF

protprobe

pvcreate /dev/xvdb1
vgcreate vgdata /dev/xvdb1
lvcreate -l 100%FREE -n lvdata vgdata
mkfs.ext4 /dev/vgdata/lvdata > /dev/null

mount /dev/vgdata/lvdata /home
mkdir /root/backup -p
cp /etc/fstab /root/backup/

echo "/dev/vgdata/lvdata   /home    ext4    defaults     1  2" >> /etc/fstab
fi
exit 0
fi
