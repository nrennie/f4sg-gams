# Load packages
library(tidyverse)
library(mgcv)

# Load data
covid <- readr::read_csv(
  "https://raw.githubusercontent.com/nrennie/f4sg-gams/main/data/covid.csv"
)

# Subset data to look at just GBR
fra_data <- covid |> 
  filter(iso_alpha_3 == "FRA") 

# Split data to train and test sets
train_prop <- 0.8
fra_train <- fra_data[1:ceiling(train_prop * nrow(fra_data)),]
fra_test <- fra_data[(ceiling(train_prop * nrow(fra_data)) + 1):nrow(fra_data),]

# Plot the data
plot(fra_train$date, fra_train$confirmed,
     type = "l",
     xlab = "Date", ylab = "Confirmed cases per day")

# Which other variables may be of interest?
plot(fra_train$tests, fra_train$confirmed,
     xlab = "Tests performed", ylab = "Confirmed cases per day")

# fit a linear model using gam()
lm_gam <- gam(confirmed ~ date_obs, data = fra_train)
coef(lm_gam)

