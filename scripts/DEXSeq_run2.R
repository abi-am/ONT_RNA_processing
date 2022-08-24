library(DEXSeq)
load("se.RData")
sample_data <- read.delim(file = "/data/groups/group_3/ont_data/sample_list.tsv", sep = "\t")
rownames(sample_data) <- sample_data$sample_alias
cell_line_ref <- unique(sample_data[se$name,"cellLine"])
for(n in 1:length(cell_line_ref)) {
  se@colData@listData[["condition"]]<- relevel(se@colData@listData[["condition"]], ref = cell_line_ref[n])
  dxd <- DEXSeqDataSet(countData = round(assays(se)$counts), sampleData = as.data.frame(colData(se)),
                       design = ~sample + exon + condition:exon, featureID = rowData(se)$TXNAME, groupID = rowData(se)$GENEID)
  dxr <- DEXSeq(dxd, quiet=FALSE, BPPARAM=MulticoreParam(workers = 12))
  file_name <- paste("dxr_", n,".RData", sep = "")
  save(dxr,file = file_name)
}
