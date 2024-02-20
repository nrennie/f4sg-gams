# fit model using gam()
gam_1 <- gam(confirmed ~ s(date_obs), data = fra_train)
coef(gam_1)

# Plot the linear predictor
plot(gam_1)
plot(fra_train$date_obs, fra_train$confirmed,
     type = "l",
     xlab = "Day of observation", ylab = "Confirmed cases per day")
lines(fra_train$date_obs, gam_1$fitted.values, col = "red")

# Adding additional terms
gam_2 <- gam(confirmed ~ s(date_obs) + s(tests), data = fra_train)
coef(gam_2)
plot(gam_2)

gam_3 <- gam(confirmed ~ s(date_obs) + s(day, k = 7), data = fra_train, method = "REML")
plot(fra_train$date_obs, fra_train$confirmed,
     type = "l",
     xlab = "Day of observation", ylab = "Confirmed cases per day")
lines(fra_train$date_obs, gam_3$fitted.values, col = "red")

# Controlling smoothness
# Bigger value = smoother
gam_4 <- gam(confirmed ~ s(date_obs, sp = 0.4), data = fra_train)
plot(gam_4)

# "REML"
gam_5 <- gam(confirmed ~ s(date_obs) + s(day, k = 7), data = fra_train, method = "REML")
plot(gam_5)

# Visualising
library(gratia)
draw(gam_5)


