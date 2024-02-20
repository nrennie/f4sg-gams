# fit model using gam()
gam_1 <- gam(confirmed ~ s(date_obs), data = gbr_train)
coef(gam_1)
summary(gam_1)

# Plot the linear predictor
plot(gam_1)
plot(gbr_train$date_obs, gbr_train$confirmed,
     type = "l",
     xlab = "Day of observation", ylab = "Confirmed cases per day")
lines(gbr_train$date_obs, gam_1$fitted.values, col = "red")

# Adding additional terms
gam_2 <- gam(confirmed ~ s(date_obs) + s(tests), data = gbr_train)
summary(gam_2)

gam_3 <- gam(confirmed ~ s(date_obs) + s(tests) + s(day, k = 7), 
             data = gbr_train)
summary(gam_3)

# plot fitted values
plot(gbr_train$date_obs, gbr_train$confirmed,
     type = "l",
     xlab = "Day of observation", ylab = "Confirmed cases per day")
lines(gbr_train$date_obs, gam_3$fitted.values, col = "red")

# Controlling smoothness
# Bigger value = smoother
gam_4 <- gam(confirmed ~ s(date_obs, sp = 0.4), data = gbr_train)
plot(gam_4)

# "REML"
gam_5 <- gam(confirmed ~ s(date_obs) + s(tests) + s(day, k = 7),
             data = gbr_train,
             method = "REML")
summary(gam_5)

# Visualising
library(gratia)
draw(gam_5)


