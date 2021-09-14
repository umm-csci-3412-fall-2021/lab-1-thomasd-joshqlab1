#!/bin/bash

cd $1 || exit 1

cat var/log/secure* > random.txt 

grep -hr "Failed password for" random.txt > output.txt

awk '{if ($0 ~ /invalid user/) {print $1 " " $2 " " substr($3,1,2) " " $11 " " $13} else {print $1 " " $2 " " substr($3,1,2) " " $9 " " $11}}' output.txt > failed_login_data.txt 
