bam_list <- list.files("/data/groups/group_3/alignments/ont_bams_genome/", recursive = T, full.names = T)[grep("bai", list.files("/data/groups/group_3/alignment>

direct_cdna_samples <- bam_list[grep("directcDNA", bam_list)]

library(bambu)
fa.file <- "/data/groups/group_3/reference_and_annotation/genome_fasta/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa"
gtf.file <- "/data/groups/group_3/reference_and_annotation/gtf_file/Homo_sapiens.GRCh38.91.gtf"
bambuAnnotations <- prepareAnnotations(gtf.file)
se <- bambu(reads = direct_cdna_samples, annotations = bambuAnnotations, genome = fa.file, ncore = 10)

save(se, file = "se.RData")
