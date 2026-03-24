library(meta)

# Import data
data_file <- "data/incense_lung_cancer_counts.csv"
name1 <- read.csv(data_file)

# Re-run meta-analysis
m.bin <- metabin(
  event.e = Case,
  n.e = Total_Case,
  event.c = Control,
  n.c = Total_Control,
  data = name1,
  studlab = Study,
  comb.fixed = TRUE,
  comb.random = TRUE,
  method = "MH",
  sm = "OR"
)

# Publication bias test
bias_result <- metabias(m.bin, method.bias = "Egger", k.min = 3, plotit = FALSE)

print(bias_result)

# Save result
sink("outputs/publication_bias.txt")
cat("Publication Bias Assessment\n\n")
print(bias_result)
sink()

cat("Publication bias analysis completed successfully.\n")