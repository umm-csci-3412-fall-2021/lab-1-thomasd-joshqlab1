#!/bin/bash

#Compine all the html files into one html file
cat "$1"/country_dist.html "$1"/hours_dist.html  "$1"/username_dist.html > "$1"/temp.html

#Use wrap contents to make an html file with the necesary header and footer for google charts
bin/wrap_contents.sh "$1"/temp.html html_components/summary_plots "$1"/failed_login_summary.html

#Remove the temp html file
rm "$1"/temp.html