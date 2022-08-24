This is OMICSS 2022 Nanopore RNA-seq data analysis project.

![alt text](https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=Bioinfomatics.drawio#R3Vldc5s4FP01ntl9yA7fth%2F91exOm92mzm7bfdkRcAGlAhEhYtxfXwHCgEUSZ6dJbL8wcK4E0jnnXiEYmYu4uGQoja6oD2RkaH4xMpcjw5hMJ%2BJYAtsasIxpDYQM%2BzWkt8AafwcJahLNsQ9ZryGnlHCc9kGPJgl4vIchxuim3yygpP%2FUFIWgAGsPERX9jH0eyWnZWov%2FDjiMmifrmozEqGksgSxCPt10IHM1MheMUl6fxcUCSMldw0vd790D0d3AGCT8kA5fsLv2gtt%2F%2Fr3J1n%2F9tyqWrp1cSHXuEcnlhOVg%2BbZhAHxBiLykjEc0pAkiqxadM5onPpSP0cRV2%2BYDpakAdQHeAudbqS7KORVQxGMio%2BpU5OwymjMPHhm%2FJS2BWAj8kXbjul05l84DJFGXQGPgbCsaMCCI4%2Fu%2B%2BEh6KNy1a2kWJ5LpZ7BuKaxf54hgXo7Ai8D7NjIcIqYzd5k4C8uzXwKU8TvvV0UeYau0PIWibObT3K0iek%2BX8moTYQ7rFFV8bkSy9jUIMCELSiirbmsGEw88T%2BAZZ%2FQbdCLuxLZs7THV7oFxKB7luYnK3JDFYZcrmzbV9AaLOmk20V5IGft5%2BZBBGIvZd5MBEn9W1h0R9QjKMuz1ee4ny4McPunUDkX2AEMNdrCh5RM%2BUixG0gpk7ilkT3%2Bz%2Bzepc1T269afvVsZT9%2BqTmPlVpWSu6n%2Ff3F1Ne9Oq9o5B1Y73TyqcucotM8IDpMycwYK3RVO8BVKjTMrdYr937zWjVVZwpBBKBxBEyEHikveEjdLKwY0GlSOyXLCs1E5UlU6EcLXi1dTzkcwCQaVc7wJuMFPUq4vnGkNCKcNCOe8lHC6mlCnVcea%2BvR0IbOPqpDpp%2F66fDjxx%2FXC3Iy7Q%2FwlJCDu9UdGA8piEVsVqShOWVW7tJngc5vh7LzWEOvo1hBDXUROLCPsAzPCcI4rI9SdypoznIQ3GFQJXsr1QWAMu953XMd2fo7rbavv%2BvGbm147ddOPD10GpkdleuOZ2%2FPTJd6wjop4XS3zcxS7%2BXkXGvPNK02Tfx3elzgIoJwkRmX3%2BjXooZcfZYe2XK3h7hW31q%2Bim7mnm2W%2FtW6G%2BqVpT7dVUUn1d1b%2BfxjS6YsQ6sx0Gh%2BfTupOWm4o1hvMvUhVps4t%2BHTeyrxm4YvZh%2B%2Fv5u81bfl%2B%2BZVP3evb5d2FMbDQ11IEtPqo3DLv3OW0CVxk1Zo9Ew0MKy0qcpq4wALk9fvc4BjKb1l%2FwkYcP9EYJd0OteTtFrMxhbYEDl79mUz7iFMgONllsZhvPca6t2IUXjukI3lf2oQmsOcDCaHyq6m49ITQIPB5KTD2EJnJQIx9v3rFGfLY0I8HxSEDPnp4N9r3jKN6ZleYu56xnu8Zcdn%2BJ63%2FBrQ%2Fm83VDw%3D%3D)

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

_Bambu_

bam.list contains all the bam files from /data/groups/group_3/alignments/ont_bams_genome folder.
direct_cdna_samples contains all directcDNA files
fa.file is the genome fasta file Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.
gtf.file is the gtf fole Homo_sapiens.GRCh38.91.gtf. 
prepareAnnotations method takes gtf.file as an input and stores the output CompressedGRangesList file in bambuAnnotations variable. 
For bambu method has direct_cdna_samples, bambuAnnotations and fa.file are given as an input to run in 10 threads and its output is saved in se variable.
The output is saved in se.RData file. 
