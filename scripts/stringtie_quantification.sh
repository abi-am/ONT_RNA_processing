#!/bin/bash
find /data/groups/group_3/alignments/ont_alignments_genome/ | grep "directcDNA" | grep -v bai | grep bam | parallel --verbose -j 1 \
"stringtie -p 10 -G /data/groups/group_3/reference_and_annotation/gtf_file/Homo_sapiens.GRCh38.91.gtf -L \
-b /data/home/arpine_grigoryan/stringtie_output/{/.} {} > {/.}.gtf"
