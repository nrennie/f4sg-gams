# Load packages
library(tidyverse)
library(mgcv)

# Load data
covid <- read_csv("data/covid.csv")

# Subset data to look at just GBR
gbr_data <- covid |> 
  filter(iso_alpha_3 == "GBR") 

# Split data to train and test sets
train_prop <- 0.8
gbr_train <- gbr_data[1:ceiling(train_prop * nrow(gbr_data)),]
gbr_test <- gbr_data[(ceiling(train_prop * nrow(gbr_data)) + 1):nrow(gbr_data),]

# Plot the data
plot(gbr_train$date, gbr_train$deaths,
     type = "l",
     xlab = "Date", ylab = "Cumulative deaths per 100,000")

# Which other variables may be of interest?




