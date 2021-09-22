#!/bin/bash

#Save working directory
dir=$(pwd)

#CD into given directory
cd "$1" || exit 1

#Find all the files named failed_login_data.txt and cat them into one file
find . -type f -name '*failed_login_data.txt' -exec cat {} + | \

#Only grab the column that has the hour
awk '{print $3}' | \

#Sort the hours
sort | \

#Count how many times each hour appears
uniq -c | \

#Print the hours and how many times they appear with data.addRow([])
awk '{print "data.addRow([\x27"$2"\x27, " $1"]);"}' > temp.txt

#Go back to main
cd "$dir" || exit 1

#Wrap the data into and html file
bin/wrap_contents.sh "$1"/temp.txt html_components/hours_dist "$1"/hours_dist.html

#Go back into given directory
cd "$1" || exit 1

#Remove temp file
rm temp.txt