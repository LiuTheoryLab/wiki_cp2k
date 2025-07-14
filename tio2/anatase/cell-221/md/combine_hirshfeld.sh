#!/bin/bash

mkdir hirshfeld
#mkdir database

num_atoms=48
num_lines=$((num_atoms + 8))

cd hirshfeld

directory="."
output_file="combined.hirshfeld"
output_file2="index.hirshfeld"
rm $output_file
rm $output_file2

start=0
end=1000000

# Loop over the range of files

for i in $(seq $start $end); do

    file="$directory/hirshfeld-1_$i.hirshfeld"

    # Check if the file exists to avoid errors

    if [[ -s "$file" ]]; then

        tail -n $num_lines "$file" >> "$output_file"
		#echo $file
		#echo $i
		echo $i >> "$output_file2"
    fi

done

cd ..
cp hirshfeld/$output_file .
cp hirshfeld/$output_file2 .
mv $output_file tio2-charges-1-clean.hirshfeld


