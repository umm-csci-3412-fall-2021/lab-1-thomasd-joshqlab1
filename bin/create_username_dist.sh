#!/bin/bash

#Save working directory
dir=$(pwd)

#CD into given directory
cd "$1" || exit 1

#Find all the files named failed_login_data.txt and cat them into one file
find . -type f -name '*failed_login_data.txt' -exec cat {} + | \

#Only grab the column that has the user name
awk '{print $4}' | \

#Sort the names
sort | \

#Count how many times each name appears
uniq -c | \

#Print the names and how many times they appear with data.addRow([])
awk '{print "data.addRow([\x27"$2"\x27, " $1"]);"}' > temp.txt

#Go back to main
cd "$dir" || exit 1

#Wrap th data into and html file
bin/wrap_contents.sh "$1"/temp.txt html_components/username_dist "$1"/username_dist.html

#Go back into given directory
cd "$1" || exit 1

#Remove temp file
rm temp.txt