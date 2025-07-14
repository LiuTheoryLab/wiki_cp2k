#!/bin/bash

./combine_hirshfeld.sh

rm index_frc.txt
rm index_pos.txt
grep 'i = ' tio2-frc-1.xyz | awk '{print $3}' >> index_frc.txt
grep 'i = ' tio2-pos-1.xyz | awk '{print $3}' >> index_pos.txt


