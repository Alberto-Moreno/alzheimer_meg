library(tidyverse)

# Read the original data file
file_path <- "/home/rstudio/data/meg_mci.csv"
rds_path <- "/home/rstudio/data/meg_mci.rds"

original_dataset <- read_csv(file_path, col_types = cols(
  .default = col_double(),
  id = col_character(),
  class = col_factor(c("1", "2"))
))
rownames(original_dataset) <- original_dataset$id
saveRDS(original_dataset, rds_path)

data_mean <- original_dataset %>% select(id, class, ends_with("mean"))
data_median <- original_dataset %>% select(id, class, ends_with("median"))
data_std <- original_dataset %>% select(id, class, ends_with("std"))
data_mad <- original_dataset %>% select(id, class, ends_with("mad"))
data_cov <- original_dataset %>% select(id, class, ends_with("cov"))

saveRDS(data_mean, "/home/rstudio/data/mean.rds")
saveRDS(data_median, "/home/rstudio/data/median.rds")
saveRDS(data_std, "/home/rstudio/data/std.rds")
saveRDS(data_mad, "/home/rstudio/data/mad.rds")
saveRDS(data_cov, "/home/rstudio/data/cov.rds")

