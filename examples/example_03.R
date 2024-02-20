# Model check
gam.check(gam_5)

# k = 10 is the default
# it seems too small
gam_6 <- gam(confirmed ~ s(date_obs, k = 20) + s(tests) + s(day, k = 7),
             data = gbr_train,
             method = "REML")
summary(gam_6)
gam.check(gam_6)
plot(gbr_train$date_obs, gbr_train$confirmed,
     type = "l",
     xlab = "Day of observation", ylab = "Confirmed cases per day")
lines(gbr_train$date_obs, gam_6$fitted.values, col = "red")

# Obtain fitted values
# Same as `glm` function in R
predict(gam_6) 
gam_6$fitted.values

# Predictions for new data
test_predictions <- predict(gam_6, newdata = gbr_test, se.fit = TRUE) 
plot(gbr_test$date_obs, gbr_test$confirmed,
     type = "l",
     xlab = "Day of observation", ylab = "Confirmed cases per day")
lines(gbr_test$date_obs, test_predictions$fit, col = "red")

# Model interpretation
predict(gam_6, type = "terms")[1,]
sum(predict(gam_6, type = "terms")[1,]) + coef(gam_6)[1]
gam_6$fitted.values[1]