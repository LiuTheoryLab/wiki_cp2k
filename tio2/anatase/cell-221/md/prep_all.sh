#!/bin/bash

job_file=prep_job_serial.sh

#DIRS=("neutral-4hours-100k-COMVEL_TO-1e-10-TEMPTOL-10-200k-300k-400k-500k-csvr-timecon-1-COMVEL_TO-1e-10-nvt-u-3.5-electron-dz2-u-3.0-rs-print-u-2.8" "neutral-4hours-100k-COMVEL_TO-1e-10-TEMPTOL-10-200k-300k-400k-500k-csvr-timecon-1-COMVEL_TO-1e-10-nvt-u-3.5-electron-dz2-u-3.0-rs-print-u-2.9" "neutral-4hours-100k-COMVEL_TO-1e-10-TEMPTOL-10-200k-300k-400k-500k-csvr-timecon-1-COMVEL_TO-1e-10-nvt-u-3.5-electron-dz2-u-3.0-rs-print-600k" "neutral-4hours-100k-COMVEL_TO-1e-10-TEMPTOL-10-200k-300k-400k-500k-csvr-timecon-1-COMVEL_TO-1e-10-nvt-u-3.5-electron-dz2-u-3.0-rs-print-700k")
#for DIR in "${DIRS[@]}"; do

#for DIR in *dz2-u-3.0-rs-print*/; do
#for DIR in *cell-mckenna*/; do
for DIR in *-u-*/; do
	cd $DIR
	echo $DIR
	cp ../$job_file .
	cp ../combine_hirshfeld.sh .
	sbatch $job_file
        cd ..
done


