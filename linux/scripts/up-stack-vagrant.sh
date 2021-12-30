#!/bin/bash

#Export Shared Objects path
export LD_LIBRARY_PATH=.

echo '[Start Lock Server]'
cd /totvs/bin/appserver/lockserver
./app_lockserver daemon
sleep 5

echo '[Start License Server]'
cd /totvs/license/bin/appserver
./app_license daemon
sleep 2

echo '[Start DBAccess Server]'
cd /totvs/dbaccess/multi
./dbaccess64 daemon
sleep 2

echo '[Start Slave01]'
cd /totvs/bin/appserver/slave01
./app_slave01 daemon
