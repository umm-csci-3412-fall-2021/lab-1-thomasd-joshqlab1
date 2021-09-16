#!/bin/bash

cat "$1"/country_dist.html "$1"/hours_dist.html  "$1"/username_dist.html> "$1"/temp.html

bin/wrap_contents.sh "$1"/temp.html html_components/summary_plots "$1"/failed_login_summary.html

rm "$1"/temp.html