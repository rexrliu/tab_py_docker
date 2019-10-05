#!/bin/bash

# start ssh
tabpy-user-management add -u $1 -p $2 -f /opt/conda/etc/pass.txt
tabpy --config=/opt/conda/etc/file.conf
