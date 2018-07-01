library(tidyverse)

# Read the original data file
file_path <- "/home/rstudio/data/meg_mci.csv"
rds_path <- "/home/rstudio/data/meg_mci.rds"

original_dataset <- read_csv(file_path)
saveRDS(original_dataset, rds_path)
