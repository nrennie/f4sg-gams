# look at autocorrelation in residuals
# caution: in this example, data is not equally spaced!
acf(gam_6$residuals)
pacf(gam_6$residuals)

# fit a `gamm()`
gamm_1 <- gamm(confirmed ~ s(date_obs) + s(day, k = 7), data = gbr_train)

# add a correlation structure
gamm_2 <- gamm(confirmed ~ s(date_obs) + s(day, k = 7),
  correlation = corARMA(form = ~ 1 | date_obs, p = 1),
  data = gbr_train
)
