#!/bin/bash
#SBATCH--mem=32gb
#SBATCH--output=slurm-%j.log
#SBATCH--thread-spec=20

path=$1
cd $path
for file in `ls $path | grep "directcDNA"`
do
        SAMPLE=`ls $file`
        minimap2 -t 20 -ax splice --junc-bed /data/groups/group_3/reference_and_annotation/gtf_file/anno_new.bed \                                              >
        /data/groups/group_3/reference_and_annotation/genome_fasta/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \                                             >
        $file/$SAMPLE  | samtools view -b > ${file}.bam
done
