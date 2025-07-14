#!/bin/bash

# Define the output file

output_file="output.out"

# Clear the output file if it exists
> "$output_file"

echo "dir first_energy last_energy homo_lumo_gap_alpha homo_lumo_gap_beta homo_energy_alpha homo_energy_beta lumo_energy_alpha lumo_energy_beta" >> "$output_file"

# List of specific directories to process
directories=("pbe" "u-2.0" "u-2.5" "u-3.0" "u-3.5" "u-4.0" "u-4.5" "u-5.0" "u-5.5" "u-6.0" "u-6.5" "u-7.0" "u-8.0" "u-9.0")
directories=("pbe" "u-2.0" "u-2.5" "u-3.0" "u-3.5" "u-4.0" "u-4.5" "u-5.0" "u-5.5" "u-6.0" "u-6.5" "u-7.0" "u-7.5" "u-7.5-rs-8.0-energy" "u-7.5-rs-8.5-energy" "u-7.5-rs-9.0-energy")
directories=("pbe" "u-2.0" "u-2.1" "u-2.2" "u-2.3" "u-2.4" "u-2.5" "u-2.6" "u-2.7" "u-2.8" "u-2.9"  "u-3.0" "u-3.5" "u-4.0" "u-4.5" "u-5.0" "u-5.5" "u-6.0" "u-6.5" "u-7.0" "u-7.5" "u-7.5-rs-8.0-energy" "u-7.5-rs-8.5-energy" "u-7.5-rs-9.0-energy")
#directories=("pbe" "u-2.0" "u-2.5" "u-3.0" "u-3.5" "u-4.0" "u-4.5" "u-5.0" "u-5.5" "u-6.0" "u-6.5" "u-7.0" "u-7.0-rs-8.0-single" "u-7.0-rs-8.0-single-rs-9.0-eps-scf-5e-6")

# Loop over the specific directories
for dir in "${directories[@]}"; do

    log_file="${dir}/cp2k_log.log"


    first_occurrence=$(grep "Total F" "$log_file" | head -n 1)
    first_energy=$(echo "$first_occurrence" | awk -F ':' '{print $2}' | awk '{print $1}')
    last_occurrence=$(grep "Total F" "$log_file" | tail -n 1)
    last_energy=$(echo "$last_occurrence" | awk -F ':' '{print $2}' | awk '{print $1}')

    homo_lumo_gap_alpha_last=$(grep "HOMO - LUMO gap" $log_file | awk '{print $7}' | tail -n 2 | head -n 1)
    homo_lumo_gap_beta_last=$(grep "HOMO - LUMO gap" $log_file | awk '{print $7}' | tail -n 1)

    homo_energy_alpha_last=$(awk '/Fermi Energy/ {print prev} {prev=$0}' $log_file | awk '{print $4}' | tail -n 2 | head -n 1)
    homo_energy_beta_last=$(awk '/Fermi Energy/ {print prev} {prev=$0}' $log_file | awk '{print $4}' | tail -n 1)
    homo_energy_alpha_first=$(awk '/Fermi Energy/ {print prev} {prev=$0}' $log_file | awk '{print $4}'  | head -n 1)
    homo_energy_beta_first=$(awk '/Fermi Energy/ {print prev} {prev=$0}' $log_file | awk '{print $4}' | head -n 2 | tail -n 1)

    lumo_energy_alpha_last=$(awk '/Eigensolver reached convergence/ {getline; print $1}' $log_file | tail -n 2 | head -n 1)
    lumo_energy_beta_last=$(awk '/Eigensolver reached convergence/ {getline; print $1}' $log_file | tail -n 1)
    lumo_energy_alpha_first=$(awk '/Eigensolver reached convergence/ {getline; print $1}' $log_file | head -n 1)
    lumo_energy_beta_first=$(awk '/Eigensolver reached convergence/ {getline; print $1}' $log_file | head -n 2 | tail -n 1)

    echo "$dir $first_energy $last_energy $homo_lumo_gap_alpha_last $homo_lumo_gap_beta_last $homo_energy_alpha_last $homo_energy_beta_last $homo_energy_alpha_first $homo_energy_beta_first $lumo_energy_alpha_last $lumo_energy_beta_last $lumo_energy_alpha_first $lumo_energy_beta_first" >> "$output_file"


done

echo "Results have been written to $output_file"
