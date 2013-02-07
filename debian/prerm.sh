#!/bin/bash

case "$1" in
    remove)
        find /usr/local/lib/python2.7/dist-packages/pysamba -name *.pyc -exec rm {} \;
        find /usr/local/lib/python2.7/dist-packages/zenoss_utils -name *.pyc -exec rm {} \;
    ;;
esac
