#!/bin/bash

sudo find / -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 10
