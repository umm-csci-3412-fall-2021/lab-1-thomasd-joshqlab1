#!/bin/bash

TMPDIR=$(mktemp -d) || exit 1

here=$(pwd)
for var in "$@"
do
    dirname="${var%.*}"
    dirname2="${dirname#log_files/}"
    cd "$TMPDIR" || exit
    mkdir "$dirname2"
    cd "$here" || exit
    tar -xf "$var" -C "$TMPDIR"/"$dirname2"
    bin/process_client_logs.sh "$TMPDIR"/"$dirname2"
done

bin/create_username_dist.sh "$TMPDIR"
bin/create_hours_dist.sh "$TMPDIR"
bin/create_country_dist.sh "$TMPDIR"
bin/assemble_report.sh "$TMPDIR"


mv "$TMPDIR"/failed_login_summary.html "$here"
rm "$TMPDIR"
echo "$TMPDIR"

