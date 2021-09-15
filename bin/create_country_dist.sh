#!/bin/bash

#Save working directory
dir=$(pwd)

#CD into given directory
cd "$1" || exit 1

#Find all the files named failed_login_data.txt and cat them into one file
find . -type f -name '*failed_login_data.txt' -exec cat {} + | \

#Only grab the column that has the IP
awk '{print $5}' | \

#Sort the IPs
sort > temp.txt
sort < "$dir"/etc/country_IP_map.txt > temp2.txt

#Join the IPs
join temp.txt temp2.txt | \

#Grab only the country code from the join
awk '{print $2}' | \

sort | \

#Count how many times each country code appears
uniq -c | \

#Print the country codes and how many times they appear with data.addRow([])
awk '{print "data.addRow([\x27"$2"\x27, " $1"]);"}' > temp3.txt

#Go back to main
cd "$dir" || exit 1

#Wrap the data into and html file
bin/wrap_contents.sh "$1"/temp3.txt html_components/country_dist "$1"/country_dist.html

#Go back into given directory
cd "$1" || exit 1

#Remove temp file
rm temp.txt
rm temp2.txt
rm temp3.txt