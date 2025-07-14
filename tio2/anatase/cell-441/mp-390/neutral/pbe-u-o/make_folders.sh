#!/bin/bash
#
# Define the source folder

SOURCE_FOLDER="u-2.0"

# Start and end values for the new folders

START=2.5
END=9.0
STEP=0.5

START=2.1
END=2.9
STEP=0.1

# Loop through each incremental value

for VALUE in $(seq $START $STEP $END); do

    # Create the new folder name

    NEW_FOLDER="u-${VALUE}"
    
    # Copy the source folder to the new folder

    cp -r "$SOURCE_FOLDER" "$NEW_FOLDER"
    
    # Replace the U_MINUS_J value in all files within the new folder

    find "$NEW_FOLDER" -type f -exec sed -i "s/U_MINUS_J  \[eV\] 2.0/U_MINUS_J  [eV] ${VALUE}/g" {} \;
done
