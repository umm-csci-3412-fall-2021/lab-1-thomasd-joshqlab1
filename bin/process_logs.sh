#!/bin/bash

#Create a temp directory 'TMPDIR'
TMPDIR=$(mktemp -d) || exit 1

#Remember where we started
here=$(pwd)

#Loop through all the given directories and untar their contents into the temp directory
for var in "$@"
do
    #Save the file name of where we want our untared files
    dirname="${var%.*}"
    dirname2="${dirname#log_files/}"

    cd "$TMPDIR" || exit

    #Make the directoy with the name created earlier
    mkdir "$dirname2"
    cd "$here" || exit

    #Unzip the files into the new directory in the temp directory
    tar -xf "$var" -C "$TMPDIR"/"$dirname2"

    #Process the client logs of the directory
    bin/process_client_logs.sh "$TMPDIR"/"$dirname2"
done

#Running all our other bash scripts to get the final HTML
bin/create_username_dist.sh "$TMPDIR"
bin/create_hours_dist.sh "$TMPDIR"
bin/create_country_dist.sh "$TMPDIR"
bin/assemble_report.sh "$TMPDIR"

#Move the HTML to the directory process_logs.sh was called from
mv "$TMPDIR"/failed_login_summary.html "$here"

#Remove the temp directory
rm "$TMPDIR"