# fit model using gam()
gam_1 <- gam(confirmed ~ s(date_obs), data = gbr_train)
coef(gam_1)

# Plot the linear predictor
plot(gam_1)
plot(gbr_train$date_obs, gbr_train$confirmed,
     type = "l",
     xlab = "Day of observation", ylab = "Confirmed cases per day")
lines(gbr_train$date_obs, gam_1$fitted.values, col = "red")

# Adding additional terms
gam_2 <- gam(confirmed ~ s(date_obs) + s(tests), data = gbr_train)
coef(gam_2)
plot(gam_2)

# Controlling smoothness
# Bigger value = smoother
gam_3 <- gam(confirmed ~ s(date_obs, sp = 0.4), data = gbr_train)
plot(gam_3)

# "REML"
gam_4 <- gam(confirmed ~ s(date_obs), data = gbr_train, method = "REML")
plot(gam_4)

# Visualising
library(gratia)
draw(gam_4)

# Interpretation
