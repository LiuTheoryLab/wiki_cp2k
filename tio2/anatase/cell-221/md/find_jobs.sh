#!/bin/bash

# Get the list of job IDs from squeue

job_ids=$(squeue -u $USER | awk 'NR > 1 {print $1}')

# Loop through each job ID and run the find command

for job_id in $job_ids; do

    echo "Searching for files related to job ID: $job_id"
    find . -name "*$job_id*"
done
