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

### REMOVE MITOCHONDRIAL READS FROM SAM FILES
samtools view -h "output.sam" | awk 'BEGIN{while(getline<"ENCFF356LFX_GRCh38_blacklist.bed")excl[$1"\t"$2"\t"$3]=1}!($3 in excl)' > "output.rmvM.sam"
