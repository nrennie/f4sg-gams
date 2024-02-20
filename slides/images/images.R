library(ggplot2)
library(patchwork)
library(mgcv)
library(dplyr)
library(gratia)


# How smooth? -------------------------------------------------------------

set.seed(20240221)
n <- 100
test_data <- data.frame(x = rnorm(n))
test_data$y = test_data$x^2 + rnorm(n, 0, 0.4)
g1 <- gam(y ~ s(x), data = test_data)
g2 <- gam(y ~ s(x, sp = 0.01, k = 40), data = test_data)
test_data$g1 <- g1$fitted.values
test_data$g2 <- g2$fitted.values
p1 <- ggplot(test_data) +
  geom_point(aes(x, y)) +
  geom_line(aes(x, g1), colour = "blue") +
  theme_bw(base_size = 20)
p2 <- ggplot(test_data) +
  geom_point(aes(x, y)) +
  geom_line(aes(x, g2), colour = "blue") +
  theme_bw(base_size = 20)
p1 + p2 
ggsave("slides/images/smooth.png", width = 8, height = 4)


# Basis -------------------------------------------------------------------

set.seed(20240221)
df <- data.frame(x = seq(0, 1, length = 100))
bs <- basis(s(x, bs = "bs", k = 10), data = df)
betas <- data.frame(bf = factor(1:10), beta = rnorm(10))
bs <- bs |>
  left_join(betas, by = join_by("bf" == "bf")) |>
  mutate(value_w = value * beta)
spl <- bs |>
  group_by(x) |>
  summarise(spline = sum(value_w))
bs |> 
  ggplot(aes(x = x, y = value_w, colour = bf, group = bf)) +
  geom_line(show.legend = FALSE) +
  labs(y = expression(f(x)), x = "x") +
  theme_bw(base_size = 20)
ggsave("slides/images/basis1.png", width = 4, height = 4)

bs |> 
  ggplot(aes(x = x, y = value_w, colour = bf, group = bf)) +
  geom_line(show.legend = FALSE) +
  geom_line(aes(x = x, y = spline), data = spl, linewidth = 1,
            inherit.aes = FALSE) +
  labs(y = expression(f(x)), x = "x") +
  theme_bw(base_size = 20)
ggsave("slides/images/basis2.png", width = 4, height = 4)
