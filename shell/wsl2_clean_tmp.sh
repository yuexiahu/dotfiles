#!/bin/bash

# wsl2实现tmp自动清理
# https://superuser.com/questions/1170939/simulate-reboot-to-clear-tmp-on-the-windows-linux-subsystem

grep '/tmp' /etc/fstab &>/dev/null ||
  echo 'tmpfs   /tmp    tmpfs   defaults,nodev,nosuid,noatime,size=2048m  0 0' >> /etc/fstab

