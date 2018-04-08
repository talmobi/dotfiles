#!/bin/bash

find $1 -xdev -type f -size $2 -exec ls -la {} \;
