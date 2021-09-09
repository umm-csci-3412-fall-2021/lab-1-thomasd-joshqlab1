#!/bin/bash

cd $1

cat *.txt> random.txt


grep -hr "Failed password for" random.txt > output.txt

sed -e 's/\<cscirepo sshd\>|[[^][]*\]//g' output.txt > failed_login.data.txt




