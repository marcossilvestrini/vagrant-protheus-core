#!/bin/bash
cd /etc/init.d

echo 'stop Slave01'
./totvslave01 stop

echo 'stop License Server'
./totvslicense stop

echo 'stop DBAccess Server'
./totvsdbaccess stop

echo 'stop Lock Server'
./totvslockserver stop
