#!/bin/bash

#SBATCH --job-name=cp2k
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --account=e05-surfin-clo 
#SBATCH --partition=standard
#SBATCH --qos=short

module load PrgEnv-gnu
module load mkl
module load cray-fftw
module load cray-python

export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK

./combine_hirshfeld.sh

rm index_frc.txt
rm index_pos.txt
grep 'i = ' tio2-frc-1.xyz | awk '{print $3}' >> index_frc.txt
grep 'i = ' tio2-pos-1.xyz | awk '{print $3}' >> index_pos.txt

echo "Done."
