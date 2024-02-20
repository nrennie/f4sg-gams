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
plot(gbr_train$date, gbr_train$confirmed,
     type = "l",
     xlab = "Date", ylab = "Confirmed cases per day")

# Which other variables may be of interest?
plot(gbr_train$tests, gbr_train$confirmed,
     xlab = "Tests performed", ylab = "Cumulative cases per 100,000")

# fit a linear model using gam()
lm_gam <- gam(confirmed ~ date_obs, data = gbr_train)
coef(lm_gam)

