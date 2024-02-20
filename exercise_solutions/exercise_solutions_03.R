# Model check
gam.check(gam_5)
# k = 10 is the default
# it seems fine for date_obs

# Obtain fitted values
# Same as `glm` function in R
predict(gam_5) 
gam_5$fitted.values

# Predictions for new data
test_predictions <- predict(gam_5, newdata = fra_test, se.fit = TRUE) 
plot(fra_test$date_obs, fra_test$confirmed,
     type = "l",
     xlab = "Day of observation", ylab = "Confirmed cases per day")
lines(fra_test$date_obs, test_predictions$fit, col = "red")

# Model interpretation
predict(gam_5, type = "terms")[1,]
sum(predict(gam_5, type = "terms")[1,]) + coef(gam_5)[1]
gam_5$fitted.values[1]
