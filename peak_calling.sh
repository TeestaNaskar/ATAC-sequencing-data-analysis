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
module load macs/2.1.0
module load BEDTools/2.29.0

### SET WORKING DIRECTORY TO WHERE SAM FILES ARE
cd /sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/trimmed_reads_nextera/mapped/BAM

### Run MACS2 peak calling
macs2 callpeak -B -t "output.sorted.bam" --outdir . --nomodel --shift -75 --extsize 150 --nolambda --keep-dup 1 --p 0.01 --name "output"

#### Move output files to the macs2Peaks directory
find . -type f \( -name "*.xls" -o -name "*.bed" -o -name "*.bdg" -o -name "*Peak" \) -exec mv {} \
"/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/trimmed_reads_nextera/macs2peaks" \;

### Remove peaks overlapping with the genomic blacklist
bedtools intersect -wa -v -a "/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/trimmed_reads_nextera/macs2peaks/output_peaks.narrowPeak" \
-b /sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/trimmed_reads_nextera/mapped/SAM/ENCFF356LFX_GRCh38_blacklist.bed > \
"/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/trimmed_reads_nextera/macs2peaks/output.bL.narrowPeak"
