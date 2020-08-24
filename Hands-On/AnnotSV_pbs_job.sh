#!/bin/bash
#PBS -P ACD109058
#PBS -W group_list=ACD109058
#PBS -N bwa_mem_job
#PBS -l select=1:ncpus=3
#PBS -q ngscourse
#PBS -o /work1/ACD109058/queue_status/
#PBS -e /work1/ACD109058/queue_status/
#PBS -M philippe.lin@ailabs.tw
#PBS -m e

######################
REF_HG19_FASTA="/pkg/biology/reference/Homo_sapiens/GATK/hg19/ucsc.hg19.fasta"
REF_HG38_FASTA="/pkg/biology/reference/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta"
OUTPUT_DIR="/work1/ACD109058/results"
PREFIX="NA12878_MOD"
TMP_DIR="/home/u0916896777/ACD109058/temp"
######################
BWA="/pkg/biology/BWA/BWA_v0.7.17/bwa"
GATK4="/pkg/biology/GATK/GATK_v4.1.8.0/gatk"
SAMTOOLS="/pkg/biology/SAMtools/SAMtools_v1.9/bin/samtools"
SAMBAMBA="/pkg/biology/sambamba/sambamba_v0.7.1/sambamba"
ANNOVAR_TAB="/pkg/biology/ANNOVAR/ANNOVAR_20200608/table_annovar.pl"
ANNOTSV=""
######################


$ANNOTSV_PATH -SVinputFile $line -genomeBuild GRCh38 -outputDir $OUTPUT_PATH -outputFile $SAMPLE_NAME