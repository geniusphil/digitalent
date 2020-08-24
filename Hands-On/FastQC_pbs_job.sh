#!/bin/bash
#PBS -P ACD109058
#PBS -W group_list=ACD109058
#PBS -N FastQC_job
#PBS -l select=1:ncpus=3
#PBS -q ngscourse
#PBS -o /work1/ACD109058/queue_status/
#PBS -e /work1/ACD109058/queue_status/
#PBS -M philippe.lin@ailabs.tw
#PBS -m e

/pkg/biology/FastQC/FastQC_v0.11.9/fastqc -o /home/u0916896777/ACD109058/results /home/u0916896777/ACD109058/data/NA12878MOD_*.fastq.gz