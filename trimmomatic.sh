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

####LOAD MODULE#####
module load trimmomatic/0.36

####SET DIRECTORY#####
cd /sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ

####
read1=/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ/A2_R1_001.fastq.gz 
read2=/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ/A2_R2_001.fastq.gz

OutputForwardPaired=/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ/trimmomatic/A2_trimmed_paired_R1_001.fastq.gz
OutputForwardUnpaired=/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ/trimmomatic/A2_trimmed_unpaired_R1_001.fastq.gz

OutputReversePaired=/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ/trimmomatic/A2_trimmed_paired_R2_001.fastq.gz
OutputReverseUnpaired=/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ/trimmomatic/A2_trimmed_unpaired_R2_001.fastq.gz

#Run Trimmomatic
threads=8

trimmomatic PE -threads $threads $read1 $read2 \
$OutputForwardPaired $OutputForwardUnpaired \
$OutputReversePaired $OutputReverseUnpaired \
ILLUMINACLIP:/sc/arion/projects/MetaDope/naskat01/ATAC_pipeline/PBMC_pipeline/FASTQ/TruSeq3-PE.fa:2:30:10:8:true HEADCROP:3 TRAILING:10 MINLEN:25
