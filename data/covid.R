library(COVID19)

# Download data
covid_data <- COVID19::covid19(c("GBR", "FRA"))

# Data from 10 Jan 2021 to 19 May 2022 since this is complete data
# Documentation: https://covid19datahub.io/articles/docs.html
covid <- covid_data |> 
  tibble::as_tibble() |> 
  dplyr::select(iso_alpha_3, date, deaths, confirmed, tests,
                vaccines, people_vaccinated, people_fully_vaccinated,
                hosp, population) |> 
  dplyr::filter(date >= lubridate::ymd("20210110")) |> 
  dplyr::filter(date <= lubridate::ymd("20220519")) 

# save to CSV
readr::write_csv(covid, "data/covid.csv")
