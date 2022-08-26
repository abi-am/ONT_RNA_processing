t_tabs <- list.files("stringtie_output/", recursive = T, full.names = T)[grep("t_data.ctab", list.files("stringtie_output/", recursive = T))]
quants <- importIsoformExpression(sampleVector = t_tabs, readLength = 1880.625)


#creating Design matrix
colnames(quants$abundance)[2:24] <- gsub("/t_data.ctab", "", gsub("/data/home/arpine_grigoryan/stringtie_output//", "", list.files("/data/home/arpine_grigoryan/stringtie_output/", full.names = T, recursive = T, pattern = "t_data.ctab")))
colnames(quants$counts)[2:24] <- gsub("/t_data.ctab", "", gsub("/data/home/arpine_grigoryan/stringtie_output//", "", list.files("/data/home/arpine_grigoryan/stringtie_output/", full.names = T, recursive = T, pattern = "t_data.ctab")))
colnames(quants$length)[2:24] <- gsub("/t_data.ctab", "", gsub("/data/home/arpine_grigoryan/stringtie_output//", "", list.files("/data/home/arpine_grigoryan/stringtie_output/", full.names = T, recursive = T, pattern = "t_data.ctab")))
sample_data <- read.delim(file = "/data/groups/group_3/ont_data/sample_list.tsv", sep = "\t", stringsAsFactors = F)
rownames(sample_data) <- sample_data$sample_alias
sample_data_filtered <- sample_data[colnames(quants$abundance)[2:24],]
myDesign <- data.frame(sampleID = colnames(quants$abundance)[-1], condition = sample_data_filtered$cellLine)

#creating Switch List 
aSwitchList <- importRdata(
  isoformCountMatrix   = quants$counts,
  isoformRepExpression = quants$abundance,
  designMatrix         = myDesign,
  isoformExonAnnoation = "/data/groups/group_3/reference_and_annotation/gtf_file/Homo_sapiens.GRCh38.91.gtf",
  isoformNtFasta       = "/data/groups/group_3/reference_and_annotation/transcriptome_fasta/Homo_sapiens.GRCh38.cdna.ncrna.fa",
  fixStringTieAnnotationProblem = FALSE, 
  ignoreAfterPeriod = TRUE,
  showProgress = TRUE
)

#Analysis part 1: Outputs of this function is analysed externally 
aSwitchList2 <- isoformSwitchAnalysisPart1(
  switchAnalyzeRlist   = aSwitchList,
  pathToOutput = "/data/home/arpine_grigoryan/isoSwitch" ,
  outputSequences      = TRUE, # change to TRUE whan analyzing your own data 
  prepareForWebServers = TRUE  # change to TRUE if you will use webservers for external sequence analysis
)

#Analysis part 2
ont_switches_with_consequences <- isoformSwitchAnalysisPart2(
  switchAnalyzeRlist        = aSwitchList2, 
  removeNoncodinORFs        = TRUE,
  pathToCPC2resultFile      = "/data/home/arpine_grigoryan/isoSwitch/cpc_prediction.tsv.txt",
  pathToPFAMresultFile      = "/data/home/arpine_grigoryan/isoSwitch/pfam_full.tsv",
  pathToIUPred2AresultFile  = "/data/home/arpine_grigoryan/isoSwitch/isoformSwitchAnalyzeR_isoform_AA_complete.result",
  pathToSignalPresultFile   = "/data/home/arpine_grigoryan/isoSwitch/output_protein_type.txt",
  outputPlots               = FALSE  # keeps the function from outputting the plots from this example
)

#Extracting genes with significant consequences
extractSwitchSummary(
  ont_switches_with_consequences,
  filterForConsequences = TRUE
) 

#Subsetting
subset(
  extractTopSwitches(ont_switches_with_consequences, filterForConsequences = TRUE, n=20, inEachComparison = TRUE)
  [,c('gene_name','condition_1','condition_2','gene_switch_q_value','Rank')],
  gene_name == "ADRM1")

#Plotting the switches
  switchPlot(
  ont_switches_with_consequences,
  gene='ADRM1',
  condition1 = 'Hct116',
  condition2 = 'A549',
  localTheme = theme_bw(base_size = 13) # making text sightly larger for vignette
)

extractConsequenceSummary(
  ont_switches_with_consequences,
  consequencesToAnalyze='all',
  plotGenes = FALSE,           # enables analysis of genes (instead of isoforms)
  asFractionTotal = FALSE      # enables analysis of fraction of significant features
) 

extractConsequenceEnrichment(
  ont_switches_with_consequences,
  consequencesToAnalyze='all',
  analysisOppositeConsequence = TRUE,
  returnResult = FALSE # if TRUE returns a data.frame with the summary statistics
) 

extractSplicingEnrichment(
  ont_switches_with_consequences,
  returnResult = FALSE # if TRUE returns a data.frame with the summary statistics
)

ggplot(data=ont_switches_with_consequences$isoformFeatures, aes(x=dIF, y=-log10(isoform_switch_q_value))) +
  geom_point(
    aes( color=abs(dIF) > 0.1 & isoform_switch_q_value < 0.05 ), # default cutoff
    size=1
  ) +
  geom_hline(yintercept = -log10(0.05), linetype='dashed') + # default cutoff
  geom_vline(xintercept = c(-0.1, 0.1), linetype='dashed') + # default cutoff
  facet_wrap( ~ condition_2) +
  #facet_grid(condition_1 ~ condition_2) + # alternative to facet_wrap if you have overlapping conditions
  scale_color_manual('Signficant\nIsoform Switch', values = c('black','red')) +
  labs(x='dIF', y='-Log10 ( Isoform Switch Q Value )') +
  theme_bw()

ggplot(data=ont_switches_with_consequences$isoformFeatures, aes(x=gene_log2_fold_change, y=dIF)) +
  geom_point(
    aes( color=abs(dIF) > 0.1 & isoform_switch_q_value < 0.05 ), # default cutoff
    size=1
  ) + 
  facet_wrap(~ condition_2) +
  #facet_grid(condition_1 ~ condition_2) + # alternative to facet_wrap if you have overlapping conditions
  geom_hline(yintercept = 0, linetype='dashed') +
  geom_vline(xintercept = 0, linetype='dashed') +
  scale_color_manual('Signficant\nIsoform Switch', values = c('black','red')) +
  labs(x='Gene log2 fold change', y='dIF') +
  theme_bw()
