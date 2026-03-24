library(meta)

# Import data
data_file <- "data/incense_lung_cancer_counts.csv"
name1 <- read.csv(data_file)

# Mantel-Haenszel meta-analysis
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

# Print results in console
print(m.bin)

# Forest plot shown in Plots pane
forest(
  m.bin,
  sortvar = TE,
  prediction = FALSE,
  print.tau2 = FALSE,
  col.diamond = "red",
  col.diamond.lines = "black",
  col.square = "royalblue1",
  col.square.lines = "black",
  label.e = "Case",
  label.c = "Control",
  common = TRUE,
  random = FALSE
)

# Save forest plot as PNG
png("outputs/forestplot.png", width = 1600, height = 900, res = 150)

forest(
  m.bin,
  sortvar = TE,
  prediction = FALSE,
  print.tau2 = FALSE,
  col.diamond = "red",
  col.diamond.lines = "black",
  col.square = "royalblue1",
  col.square.lines = "black",
  label.e = "Case",
  label.c = "Control",
  common = TRUE,
  random = FALSE
)

dev.off()

# Funnel plot shown in Plots pane
funnel(m.bin)

# Save funnel plot as PNG
png("outputs/funnelplot.png", width = 1600, height = 900, res = 150)

funnel(m.bin)

dev.off()

# Save text summary to file
sink("outputs/meta_summary.txt")
cat("Cancer Risk Meta-Analysis Summary\n\n")
print(m.bin)
sink()

cat("Meta-analysis completed successfully.\n")