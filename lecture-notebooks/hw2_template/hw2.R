# author: <your name>
# date: <date you started>

# These are the package that will be on Gradescope.
# Other package requests should be done >2 days before the deadline.
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# -------------------------------------------------------------------
# Part 1 — Unemployment (10 points)
# -------------------------------------------------------------------

unemployment <- read_csv("data/unemployment.csv", show_col_types = FALSE)

# Q2: sort by NEI and NEI-PTER (descending)
by_nei <- NULL

by_nei_pter <- NULL

# Q3: top 11 by NEI
greatest_nei <- NULL

# Q4: PTER vector
pter <- NULL

# Q5: table sorted by PTER (descending)
by_pter <- NULL

# Q6: plot PTER over time
pter_plot <- NULL

# Q7: Answer question about the plot
highPTER <- NULL  


# -------------------------------------------------------------------
# Part 2 — Birth rates
# -------------------------------------------------------------------


pop <- read_csv("data/nst-est2016-alldata.csv", show_col_types = FALSE) |>
  filter(SUMLEV == "040") |>
  select(2, 5, 13, 14, 28, 35, 63, 70) |>
  rename(
    `2015` = POPESTIMATE2015,
    `2016` = POPESTIMATE2016,
    BIRTHS = BIRTHS2016,
    DEATHS = DEATHS2016,
    MIGRATION = NETMIG2016,
    OTHER = RESIDUAL2016
  ) |>
    mutate(
      us_birth_rate <- (pop |> pull(BIRTHS) |> sum()) / (pop |> pull(`2015`) |> sum()) = na_if(REGION, "X"),
      REGION = factor(
        REGION,
        levels = c("1", "2", "3", "4"),
        labels = c("Northeast", "Midwest", "South", "West")
      )
    )


# Q1: overall U.S. birth rate = total births / total 2015 population
us_birth_rate <- NULL

# Q2: count counties with migration rate > 0.01
movers <- NULL

# Q3: total births in the West (REGION == 4)
west_births <- NULL

# Q4: plot of birth rate vs death rate
pop_rates <- NULL

p_birth_death <- NULL

# -------------------------------------------------------------------
# Part 3 — Classic Films
# -------------------------------------------------------------------

films <- read_delim(
  "data/film.csv",
  locale = locale(encoding = "UTF-8"),
  delim = ";",
  show_col_types = FALSE
) |>
  slice(-1) |>
  type_convert() |>
  mutate(across(where(is.character), ~ iconv(.x, from = "Latin1", to = "UTF-8", sub = "")))

# Q1: Clean and arrange the data
cleaned_films <- films |> 
    mutate(Length = as.integer(Length),
           Popularity = as.integer(Popularity),
            Year = as.integer(Year),
            Subject = factor(Subject),
            Awards = ifelse(Awards == "Yes", TRUE, FALSE)) |>
    select(-`*Image`) |>
    rename(Genre = Subject) |>
    filter(!is.na(Length), !is.na(Genre)) |>
    arrange(Title)


# Q1: Movie length distributions across genres
genre_len_comp <- NULL

# Q2: Which genre has films consistently between 90 and 110 minutes?
gen1 <- NULL

# Q3: Number of films in different genres and how many got awards in each genre
genre_awards_comp <- NULL

# Q4: Which genre has 31 award-winning films?
gen2 <- NULL
