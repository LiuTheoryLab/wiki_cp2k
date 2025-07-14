#!/bin/bash

# Loop over all directories in the current directory
START=2.0
END=2.9
STEP=0.1
for VALUE in $(seq $START $STEP $END); do
   dir="u-${VALUE}"
#for dir in */; do
#dirs=("hf-13" "hf-14" "hf-15")
#for dir in "${dirs[@]}"; do

    # Check if the directory contains the file tio2-1.restart

    if [ -f "${dir}/tio2-1.restart" ]; then

        # Move tio2-1.restart to input/input.inp

        mv "${dir}/tio2-1.restart" "${dir}/input/input.inp"
        
        # Replace the lines in the input.inp file

        sed -i 's/CHARGE 1/CHARGE 0/g' "${dir}/input/input.inp"
        sed -i 's/MULTIPLICITY 2/MULTIPLICITY 1/g' "${dir}/input/input.inp"
	sed -i 's/RUN_TYPE GEO_OPT/RUN_TYPE ENERGY/g' "${dir}/input/input.inp"

	echo "Processed directory: ${dir}"
    else

        echo "Skipping directory: ${dir} (tio2-1.restart not found)"
    fi

        sed -i 's/04:00/00:20/g' "${dir}/run.slurm"
        sed -i 's/partition=short/partition=standard/g' "${dir}/run.slurm"
        sed -i 's/qos=standard/qos=short/g' "${dir}/run.slurm"

done
