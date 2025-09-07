#!/bin/bash

###################################################################################
# 29May,2025 /LS
# Checks if software and project partitions from ssd are successfully 
# mounted and only then exports them to compute node via nfs
###################################################################################
MOUNTED=0

if mountpoint -q /software; then
  echo "/software 192.168.1.0/24(ro,sync,no_subtree_check,no_root_squash)" > /etc/exports.d/software.exports
  MOUNTED=1
else
  rm -f /etc/exports.d/software.exports
fi

if mountpoint -q /project; then
  echo "/project 192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash)" > /etc/exports.d/project.exports
  MOUNTED=1
else
  rm -f /etc/exports.d/project.exports
fi

# Reload exports if anything was added
if [ $MOUNTED -eq 1 ]; then
  exportfs -ra
fi
