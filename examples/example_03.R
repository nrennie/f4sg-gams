# Within sample predictions
predict(gam_4) # fitted values


# Out of sample predictions
test_predictions <- predict(gam_4, newdata = gbr_test) 
plot(gbr_test$date_obs, gbr_test$confirmed,
     type = "l",
     xlab = "Day of observation", ylab = "Confirmed cases per day")
lines(gbr_test$date_obs, test_predictions, col = "red")

# Model evaluations
predict(gam_4, type = "terms")

