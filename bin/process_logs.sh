#!/bin/bash

TMPDIR=$(mktemp -d) || exit 1

here=$(pwd)
mkdir random
for var in "$@"
do
    dirname="${var%.*}"
    dirname2="${dirname#log_files/}"
    echo $dirname2
    cd random
    mkdir $dirname2

    tar -xf log_files/"$var" $dirname2
    #bin/process_client_logs.sh random/$dirname
    cd $here
done

echo $TMPDIR
#bin/create_username_dist.sh random
#bin/create_hours_dist.sh random
#bin/create_country_dist.sh random
#bin/assemble_report.sh random

#mv random/failed_login_summary.html $here
