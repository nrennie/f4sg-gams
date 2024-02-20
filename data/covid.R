library(COVID19)

# Download data
covid_data <- COVID19::covid19(c("GBR", "FRA"))

# Data from 10 Jan 2021 to 19 May 2022 since this is complete data
# Documentation: https://covid19datahub.io/articles/docs.html
covid_raw <- covid_data |> 
  tibble::as_tibble() |> 
  dplyr::select(iso_alpha_3, date, deaths, confirmed, tests,
                vaccines, people_vaccinated, people_fully_vaccinated,
                hosp, population) |> 
  dplyr::filter(date >= lubridate::ymd("20210110")) |> 
  dplyr::filter(date <= lubridate::ymd("20220111")) 

# save to CSV
readr::write_csv(covid_raw, "data/covid_raw.csv")
covid_raw <- readr::read_csv("data/covid_raw.csv")

# get count data instead of cumulative
covid <- covid_raw |> 
  dplyr::mutate(
    dplyr::across(deaths:people_fully_vaccinated, ~ .x - lag(.x))
  ) |> 
  tidyr::drop_na() |> 
  dplyr::group_by(iso_alpha_3) |> 
  dplyr::mutate(date_obs = row_number()) |> 
  dplyr::ungroup() |> 
  dplyr::filter(if_all(where(is.numeric), ~ .x >= 0)) |> 
  dplyr::mutate(
    day = lubridate::wday(date, week_start = 1)
  ) 

# save to CSV
readr::write_csv(covid, "data/covid.csv")








