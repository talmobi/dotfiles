#!/bin/bash

# ref: https://github.com/spikeon/digitalocean_swapfile
echo "Tested on Ubuntu 16.04";

SET_SIZE=$1
SET_SWAPPINESS=$2
SET_PRESSURE=$3

if [ -z $3 ]; then
  echo 'not enough arguments, try: '
  echo '$1 -- fallocate size ( swap size )'
  echo '$2 -- swappiness, 0-100'
  echo '$3 -- vfs_cache_pressure, 0-100'
  echo 'example:   ./swappy.sh 1G 10 50'
  exit 1
fi

echo "Setting basic swap, swappiness, and vfs_cache_pressure:"
echo "/swapfile $SET_SIZE"
echo "swappiness $SET_SWAPPINESS"
echo "vfs_cache_pressure $SET_PRESSURE"
echo ""

if [ ! -e "/swapfile" ]; then
    echo "creating swapfile";

    "fallocate -l $SET_SIZE /swapfile"
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    swapon --show

    echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
else
    echo "swapfile already exists"
fi
echo ""


SWAPPINESS=$(cat /proc/sys/vm/swappiness)
if [[ SWAPPINESS != "$SET_SWAPPINESS" ]] ; then
    echo "setting swappiness to $SET_SWAPPINESS"

    sysctl vm.swappiness="$SET_SWAPPINESS"

    # update existing vm.swappiness in /etc/sysctl.conf
    # or append new rule if it doesn't exist
    LINENR=$(grep 'vm.swappiness=' /etc/sysctl.conf -n | cut -d ':' -f1)

    if [ LINENR ] ; then
      CMD="${LINENR}s/.*/vm.swappiness=${SET_SWAPPINESS}/ /etc/sysctl.conf"
      echo $CMD
      sed -i $CMD
    else
      # didn't exist, append at the end
      echo "vm.swappiness=$SET_SWAPPINESS" | tee -a /etc/sysctl.conf
    fi
else
    echo "swappiness was OK at: $SWAPPINESS"
fi
echo ""

PRESSURE=$(cat /proc/sys/vm/vfs_cache_pressure)
if [[ PRESSURE != "$SET_PRESSURE" ]] ; then
    echo "setting vfs_cache_pressure to $SET_PRESSURE"

    sysctl vm.vfs_cache_pressure="$SET_PRESSURE"

    # update existing vm.vfs_cache_pressure in /etc/sysctl.conf
    # or append new rule if it doesn't exist
    LINENR=$(grep 'vm.vfs_cache_pressure=' /etc/sysctl.conf -n | cut -d ':' -f1)

    if [ LINENR ] ; then
      CMD="${LINENR}s/.*/vm.vfs_cache_pressure=${SET_PRESSURE}/ /etc/sysctl.conf"
      echo $CMD
      sed -i $CMD
    else
      # didn't exist, append at the end
      echo "vm.vfs_cache_pressure=$SET_PRESSURE" | tee -a /etc/sysctl.conf
    fi
else
    echo "vfs_cache_pressure was OK at: $PRESSURE"
fi
echo ""

echo "basic swap, swappiness and vfs_cache_pressure updated."
echo "check /etc/sysctl.conf"
echo ""
tail /etc/sysctl.conf
