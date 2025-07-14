#!/bin/bash

#SBATCH --job-name=cp2k
#SBATCH --nodes=1
#SBATCH --tasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --account=e05-surfin-clo 
#SBATCH --partition=standard
#SBATCH --qos=standard

module load PrgEnv-gnu
module load mkl
module load cray-fftw
module load cray-python

find . -maxdepth 1 ! -name '*slurm*' -type f -exec rm  {} +

export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK
cp input/* .

module load cp2k/cp2k-2024.3
cp2k=/work/y07/shared/apps/core/cp2k/cp2k-2024.3/toolchain_cray_default+mkl+plumed/exe/local/cp2k.psmp

input=input.inp
output=cp2k_log.log
srun --hint=nomultithread --distribution=block:block  $cp2k -i $input -o $output
