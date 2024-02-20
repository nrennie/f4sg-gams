# look at autocorrelation in residuals
# caution: in this example, data is not equally spaced!
acf(gam_5$residuals)
pacf(gam_5$residuals)

# fit a `gamm()`
gamm_1 <- gamm(confirmed ~ s(date_obs) + s(day, k = 7), data = fra_train)
AIC(gamm_1$lme)

# add a correlation structure
gamm_2 <- gamm(confirmed ~ s(date_obs) + s(day, k = 7),
               correlation = corARMA(form = ~ 1 | date_obs, p = 1),
               data = fra_train
)
AIC(gamm_2$lme) # adds too much complexity