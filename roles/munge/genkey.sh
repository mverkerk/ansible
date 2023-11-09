#!/bin/bash
#
# usage genkey.sh keyname ( will create keyname.key )
#

dd if=/dev/random bs=1 count=1024 > $1.key
