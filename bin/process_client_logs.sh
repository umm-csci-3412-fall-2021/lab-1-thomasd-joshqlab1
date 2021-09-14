#!/bin/bash

cd "$1" || exit 1

cat var/log/secure* | \

#Gets all the lines that contain the string 'Failed password for' and pipes them to the awk
grep -hr "Failed password for" | \

#If any of the lines have "invalid user" then take the 1st, 2nd, 3rd first 2 elements, 11th, and 13th columns of the text seperated by spaces
#Else take the columns 1, 2, 3 first 2 characters, 9, and 11 to print out.
awk '{if ($0 ~ /invalid user/) {print $1 " " $2 " " substr($3,1,2) " " $11 " " $13} else {print $1 " " $2 " " substr($3,1,2) " " $9 " " $11}}' > failed_login_data.txt 
