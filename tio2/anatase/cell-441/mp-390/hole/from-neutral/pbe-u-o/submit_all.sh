#!/bin/bash

# Loop over all directories in the current directory
START=2.0
END=2.9
STEP=0.1
for VALUE in $(seq $START $STEP $END); do
   dir="u-${VALUE}"
#for dir in */; do
   cd ${dir}
   echo ${dir}
   cp ../run.slurm .
   cp ../system.xyz input/
   rm slurm-*; rm hirshfeld/* ; sbatch run.slurm
   cd ..
done
