#!/bin/bash
#BSUB -J PBMC_ATACseq_TEST
#BSUB -P acc_DADisorders
#BSUB -q premium
#BSUB -n 4
#BSUB -R rusage[mem=8000]
#BSUB -R span[hosts=1]
#BSUB -W 24:00
#BSUB -o %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

### LOAD MODULES HERE
module load samtools/1.15.1
module load macs/2.1.0
module load sratoolkit/2.11.0
module load kentutils/302.1
module load bedtools/2.31.0

### SET WORKING DIRECTORY TO WHERE FILES ARE
cd /sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/trimmed_reads_nextera/macs2peaks

# Specify the treat bedGraph file for the sample
TREAT_BEDGRAPH="output_treat_pileup.bdg"

# Sort the treat bedGraph file
bedSort "$TREAT_BEDGRAPH" "output_treat_pileup.sorted.bdg"

# Convert sorted bedGraph to BigWig
bedGraphToBigWig "output_treat_pileup.bdg.sorted.bdg" \
/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/hg38.chrom.sizes \
"output_treat_pileup.bw"

# Move BigWig file to vizFiles directory
mv "output_treat_pileup.bw" \
/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/trimmed_reads_nextera/visualization_files
