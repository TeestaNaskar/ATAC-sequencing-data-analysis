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
module load bowtie2/2.4.4

#Map using bowtie
bowtie2 -x /sc/arion/projects/MetaDope/lilchizim/ATAC_pipeline/PBMC_pipeline/INDEXES/bowtie/grch38_1kgmaj \
-1 /sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ/trimmomatic/A2_trimmed_paired_R1_001.fastq.gz \
-2 /sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ/trimmomatic/A2_trimmed_paired_R2_001.fastq.gz \
-S /sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ/trimmomatic/mapped/SAM/output.sam \
2>/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ/trimmomatic/bowtieLogs/output.log
