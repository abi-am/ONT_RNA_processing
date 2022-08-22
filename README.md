This is OMICSS 2022 Nanopore RNA-seq data analysis project.

PROCESSING STEPS

1. Quality Check
For base quality check we performed FastQC on every direct cDNA fastq file. After, we aggregated results by using MultiQC tool. 

ONT_RNA_processing/scripts/quality_check.sh

2. Alignment
At first we aligned reads on whole genome and after, on transcriptome data using MiniMap2 tool.

ONT_RNA_processing/scripts/genome_alignment.sh
ONT_RNA_processing/scripts/transcriptome_alignment.sh

3. Isoform Expression Analysis
For isoform expression analysis we tried to compare 2 tools - StringTie and Bambu.

ONT_RNA_processing/scripts/stringtie_quantification.sh
ONT_RNA_processing/scripts/bambu.R
ONT_RNA_processing/scripts/bambu.sh

Bambu
bam.list contains all the bam files from /data/groups/group_3/alignments/ont_bams_genome folder.
direct_cdna_samples contains all directcDNA files
fa.file is the genome fasta file Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.
gtf.file is the gtf fole Homo_sapiens.GRCh38.91.gtf. 
prepareAnnotations method takes gtf.file as an input and stores the output CompressedGRangesList file in bambuAnnotations variable. 
For bambu method has direct_cdna_samples, bambuAnnotations and fa.file are given as an input to run in 10 threads and its output is saved in se variable.
The output is saved in se.RData file. 
