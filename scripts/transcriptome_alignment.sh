#!/bin/bash
#SBATCH--mem=32gb
#SBATCH--output=slurm-%j.log
#SBATCH--thread-spec=20

path=$1
cd $path
for file in `ls $path | grep "directcDNA"`
do
        SAMPLE=`ls $file`
        minimap2 -ax map-ont -t 20 /data/groups/group_3/reference_and_annotation/transcriptome_fasta/Homo_sapiens.GRCh38.cdna.ncrna.fa \
        $file/$SAMPLE  | samtools sort > ${file}.transcriptome_sorted.bam
done
