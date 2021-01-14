#!/bin/bash
cd /etc/init.d

echo '[status Lock Server]'
./totvslockserver status

echo '[status License Server]'
./totvslicense status

echo '[status DBAccess Server]'
./totvsdbaccess status

echo '[status Slave01]'
./totvslave01 status