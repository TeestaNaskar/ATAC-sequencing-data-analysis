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

### SET WORKING DIRECTORY TO WHERE SAM FILES ARE
cd /sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/trimmed_reads_nextera/mapped/SAM

### CONVERT .SAM TO SORTED .BAM AND CREATE INDEX
samtools view -S -b -@ 10 "output.rmvM.sam" | samtools sort -l 9 -@ 10 -o "output.sorted.bam"
samtools index -b "output.sorted.bam"
mv "output.sorted.bam" "output.sorted.bam.bai" /sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/trimmed_reads_nextera/mapped/BAM
