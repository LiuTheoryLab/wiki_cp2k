#!/bin/bash

# Loop over all directories in the current directory

for dir in */; do

        #mv "${dir}/tio2-1.restart" "${dir}/input/input.inp"
        
        # Replace the lines in the input.inp file

        sed -i 's/CHARGE 0/CHARGE -1/g' "${dir}/input/input.inp"
	sed -i 's/CHARGE -1/CHARGE 1/g' "${dir}/input/input.inp"
        sed -i 's/MULTIPLICITY 1/MULTIPLICITY 2/g' "${dir}/input/input.inp"
        
        echo "Processed directory: ${dir}"
done
