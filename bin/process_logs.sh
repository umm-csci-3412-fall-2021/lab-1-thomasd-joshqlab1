#!/bin/bash

TMPDIR=$(mktemp -d) || exit 1

here=$(pwd)

for var in "$@"
do
    dirname=$var | sed 's/\.zip$//'
    mkdir random/$dirname
    tar -xf "$var" -C random/$dirname
    #bin/process_client_logs.sh random/$dirname
done

echo $TMPDIR
bin/create_username_dist.sh random
bin/create_hours_dist.sh random
bin/create_country_dist.sh random
bin/assemble_report.sh random

mv random/failed_login_summary.html $here
