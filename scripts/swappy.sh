#!/bin/bash

# ref: https://github.com/spikeon/digitalocean_swapfile
echo "Tested on Ubuntu 16.04";

echo "Setting basic swap ( 1G /swapfile ), swappiness ( 10 ) and vfs_cache_pressure ( 50 )";

if [ ! -e "/swapfile" ]; then
    echo "creating swapfile";

    fallocate -l 1G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    swapon --show

    echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
else
    echo "swapfile already exists"
fi


echo "capping swappiness at 10"

SWAPPINESS=$(cat /proc/sys/vm/swappiness)
if (( SWAPPINESS > 10 )) ; then
    echo "setting swappiness to 10"

    sysctl vm.swappiness=10

    echo 'vm.swappiness=10' | tee -a /etc/sysctl.conf
else
    echo "swappiness was OK at: $SWAPPINESS"
fi

echo "capping vfs_cache_pressure at 50"

PRESSURE=$(cat /proc/sys/vm/vfs_cache_pressure)
if (( PRESSURE > 50 )) ; then
    echo "setting vfs_cache_pressure"

    sysctl vm.vfs_cache_pressure=50

    echo 'vm.vfs_cache_pressure=50' | tee -a /etc/sysctl.conf
else
    echo "vfs_cache_pressure was OK at: $PRESSURE"
fi

echo "basic swap, swappiness and vfs_cache_pressure updated."

