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
FASTQ1="/work1/ACD109058/data/NA12878MOD_1.fastq.gz"
FASTQ2="/work1/ACD109058/data/NA12878MOD_2.fastq.gz"
REF_HG19_FASTA="/pkg/biology/reference/Homo_sapiens/GATK/hg19/ucsc.hg19.fasta"
REF_HG38_FASTA="/pkg/biology/reference/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta"
DBSNP_HG19="/pkg/biology/reference/Homo_sapiens/GATK/hg19/dbsnp_138.hg19.vcf"
DBSNP_HG38="/home/u0916896777/ACD109058/data/dbsnp_146.hg38.vcf"
RGID="NA12878_MOD"
RGSM="NA12878_MOD"
RGLB="Illumina"
RGPL="Illumina"
RGPU="Illumina"
OUTPUT_DIR="/work1/ACD109058/results"
PREFIX="NA12878_MOD"
TMP_DIR="/home/u0916896777/ACD109058/temp"
######################
BWA="/pkg/biology/BWA/BWA_v0.7.17/bwa"
GATK4="/pkg/biology/GATK/GATK_v4.1.8.0/gatk"
SAMTOOLS="/pkg/biology/SAMtools/SAMtools_v1.9/bin/samtools"
SAMBAMBA="/pkg/biology/sambamba/sambamba_v0.7.1/sambamba"
ANNOVAR_TAB="/pkg/biology/ANNOVAR/ANNOVAR_20200608/table_annovar.pl"
######################

$ANNOVAR_TAB HG00403.chr20.gatk.avinput /work1/ACD109058/humandb/ -buildver hg38 \
-out HG00403.chr20.gatk \
-remove \
-protocol refGene,ensGene,cytoBand,genomicSuperDups,gwasCatalog,avsnp150,esp6500siv2_all,1000g2015aug_all,1000g2015aug_afr,1000g2015aug_amr,1000g2015aug_eur,1000g2015aug_eas,1000g2015aug_sas,nci60,cosmic85_coding,clinvar_20180603,gnomad_genome,exac03,intervar_20180118,dbnsfp31a_interpro \
-operation g,g,r,r,r,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f -otherinfo -nastring NA