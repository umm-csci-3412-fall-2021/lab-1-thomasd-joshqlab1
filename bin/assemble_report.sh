#!/bin/bash
dir=$(pwd)
cat "$1"/username_dist.html "$1"/hours_dist.html "$1"/country_dist.html > temp.html

cd "$dir" || exit 1
bin/wrap_contents.sh temp.html html_components/summary_plots "$1"/failed_login_summary.html