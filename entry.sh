#!/bin/sh

/usr/bin/flexget -c /config/config.yml --loglevel $LOGLEVEL daemon start --autoreload-config
