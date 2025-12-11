#!/bin/bash
# Usage: sudo lvm_fill.sh /mnt/data1 10G
mount_point=$1
size=$2
fallocate -l $size $mount_point/fillfile_$(date +%s)
df -h $mount_point
