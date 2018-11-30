#!/bin/sh

DIRECTORY=$(cd "$(dirname "$0")"; pwd)

if [ ! -e "$DIRECTORY/../config/config.local.php" ]; then
    cp $DIRECTORY/../config/config.local.php.dist $DIRECTORY/../config/config.local.php
fi

mkdir --mode=777 $DIRECTORY/../tmp
mkdir --mode=777 $DIRECTORY/../logs
mkdir --mode=777 $DIRECTORY/../../uploads
mkdir --mode=777 $DIRECTORY/../plugins 

chmod 777 $DIRECTORY/../config/config.local.php
