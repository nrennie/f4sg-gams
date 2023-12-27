library(ggplot2)

# Load data
covid <- readr::read_csv("data/covid.csv")

# Line plot
ggplot(data = covid) +
  geom_line(mapping = aes(x = date, y = deaths, colour = iso_alpha_3)) +
  labs(title = "Cumulative deaths from COVID19 per 100,000",
       subtitle = "Daily data for UK and France",
       x = "",
       y = "Cumulative deaths") +
  scale_colour_brewer(palette = "Dark2") +
  theme_light() +
  theme(legend.position = "top",
        legend.title = element_blank())
  