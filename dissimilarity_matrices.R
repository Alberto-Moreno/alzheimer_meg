# This script creates dissimilarity matrices between the sensors based on the 5 different measures
library(tidyverse)
library(corrplot)
## Auxiliary function
mean_similarity_matrix <- function(df) {
  # Remove the id and class columns
  try (df <- df %>% select(-id, -class))
  
  # Create a data frame with the indices of each name in the original data
  dissim_df <- str_split_fixed(names(df), "[[:punct:]]", 4)[,2:3] %>% 
    data.frame(stringsAsFactors = FALSE) %>% 
    mutate(X1 = as.numeric(X1),
           X2 = as.numeric(X2))
  
  # Add the similarity measure
  dissim_df$measure <- colMeans(df)
  
  # Create and populate a 102x102 matrix with the similarity measure
  dissim_matrix <- matrix(nrow = 102, ncol = 102)
  
  for (i in seq(nrow(dissim_df))) {
    dissim_matrix[dissim_df[i, 1], dissim_df[i, 2]] <- dissim_df$measure[i]
    dissim_matrix[dissim_df[i, 2], dissim_df[i, 1]] <- dissim_df$measure[i]
  }
  
  diag(dissim_matrix) <- 0

  return (dissim_matrix)
}

### Load data

data_mean <- readRDS("/home/rstudio/data/mean.rds")
data_median <- readRDS("/home/rstudio/data/median.rds")
data_std <- readRDS("/home/rstudio/data/std.rds")
data_mad <- readRDS("/home/rstudio/data/mad.rds")
data_cov <- readRDS("/home/rstudio/data/cov.rds")

dissim_mean <- mean_similarity_matrix(data_mean)
dissim_median <- mean_similarity_matrix(data_median)
dissim_std <- mean_similarity_matrix(data_std)
dissim_cov <- mean_similarity_matrix(data_cov)
dissim_mad <- mean_similarity_matrix(data_mad)

par(mfrow = c(1,1))
corrplot(dissim_mean)
corrplot(dissim_median)
corrplot(dissim_std*22)
corrplot(dissim_cov*4)
corrplot(dissim_mad*20)

dissim_mci <- mean_similarity_matrix(filter(data_mean, class == 2))
dissim_control <- mean_similarity_matrix(filter(data_mean, class == 1))

plot_ly(z = dissim_mci, type = "heatmap")
plot_ly(z = dissim_control, type = "heatmap")
plot_ly(z = dissim_mad, type = "heatmap")

