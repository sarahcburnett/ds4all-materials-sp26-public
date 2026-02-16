# Generated from apis_wbstats.ipynb
#
# This script preserves the notebook's narrative as comments
# and keeps code cells as executable R code.

# # APIs
#
# These notes introduce APIs in R and show examples using World Bank data (`wbstats`) and V-Dem data (`vdemlite`).

# ## APIs
#
# - API stands for **Application Programming Interface**
# - A way for two computers to talk to each other
# - In our case, we will use APIs to download social science data

# ## APIs in R
#
# - APIs are accessed through packages in R
# - Sometimes there can be more than one package for an API
# - Much easier than reading in data from messy flat file!
# - We will use a few API packages in this course:
#   - World Bank data through `wbstats` (or `WDI`)
#   - `fredr` for Federal Reserve Economic Data
#   - `tidycensus` for US Census data
# - But there are many APIs out there (please explore!)


# install.packages(c('tidyverse','janitor','devtools'))
# # now, install the vdemlite package directly from GitHub
# devtools::install_github("vdeminstitute/vdemdata")
# Only need to do this once on your computer

library(vdemdata)
library(dplyr)    
library(ggplot2)


# # V-Dem Data

# ## The V-Dem Dataset
#
# - V-Dem stands for **Varieties of Democracy**
# - It is a dataset that measures democracy around the world
# - Based on expert assessments of the quality of democracy in each country
# - Two packages we will explore `vdemdata`: 
# - Documentation: [https://github.com/vdeminstitute/vdemdata](https://github.com/vdeminstitute/vdemdata)

# ## `vdemdata`
#
# - Provides the most recent full V-Dem dataset in R (V-Dem indicators + indices), plus additional “other” variables bundled with the release.
# - Includes the V-Party dataset as well.  
# - Covers recent full V-Dem dataset + V-Party (long historical coverage).
# - Comes with helper functions to search, look up, and visualize V-Dem variables (codebook/variable info + quick plotting). 
# - **Probably too big to work with in JupyterHub.**

# ## 1) Load the V-Dem dataset
#
# The main country-year dataset is available as an object called `vdem`.

# Load the dataset into your environment
df_vdem <- vdem

# Quick look
glimpse(df_vdem)
names(df_vdem)[1:25]

# If you cannot load the data, try this activity on your own computer in Rstudio.

# ## 2) Find variables
#
# Use **`find_var()`** to search variables by keyword(s).

# Search by keyword (try other keywords too)
vars_demo <- find_var("polyarchy")
vars_elec <- find_var("election")

# Peek at the search results
head(vars_demo, 10)
head(vars_elec, 10)

# ## 3) Variable metadata + summary stats
#
# To get a quick overview for a variable, you can:
#
# - Use **`var_info()`** to view codebook-style metadata for a variable.
# - Compute summary stats directly from the dataset (mean, quantiles, missingness, etc.).

# Variable metadata (codebook info)
var_info("v2x_polyarchy")
var_info("v2xel_frefair")

# Summary stats for the polyarchy index across the full dataset
df_vdem |>
  summarize(
    n = n(),
    n_missing = sum(is.na(v2x_polyarchy)),
    mean = mean(v2x_polyarchy, na.rm = TRUE),
    sd = sd(v2x_polyarchy, na.rm = TRUE),
    q25 = quantile(v2x_polyarchy, 0.25, na.rm = TRUE),
    median = median(v2x_polyarchy, na.rm = TRUE),
    q75 = quantile(v2x_polyarchy, 0.75, na.rm = TRUE)
  )

# ## 4) Filter by countries/years/indicators
#
# The data is available as `vdem`, so you **filter + select**.
#
# Example: Polyarchy + Clean Elections for USA and Sweden, 2000–2020.

# Subset for USA and Sweden, 2000–2020, and select indicators
dem_indicators <- df_vdem |>
  filter(
    year >= 2000, year <= 2020,
    country_text_id %in% c("USA", "SWE")
  ) |>
  select(country_name, country_text_id, year, v2x_polyarchy, v2xel_frefair)

glimpse(dem_indicators)
dem_indicators |> arrange(country_text_id, year) |> head(10)

# ## 5) Quick visualization helper
#
# `vdemdata` includes **`plot_indicator()`** to quickly plot one or more indicators for selected countries.

# Quick plot for a single indicator
plot_indicator(
  indicator = "v2x_polyarchy",
  countries = c("United States of America", "Sweden")
)

# ## 6) Your turn (activities)
#
# 1. Use `find_var()` to locate an indicator you’re interested in (try 2–3 keywords).
# 2. Use `var_info()` to read what the indicator measures.
# 3. Create a subset for 1–3 countries and a time range of your choice.
# 4. Make a line plot over time (either with `plot_indicator()` or your own ggplot).

# 1) Search for an indicator you care about
# Example keywords: "media", "corruption", "judicial", "protest", "civil society"
my_vars <- find_var("corruption")
head(my_vars, 15)

# 2) Pick one variable name from the results (replace with your choice)
my_indicator <- "v2x_polyarchy"
var_info(my_indicator)

# 3) Subset (replace countries + years as you like)
my_data <- df_vdem |>
  filter(year >= 1995, year <= 2020,
         country_text_id %in% c("USA", "SWE", "BRA")) |>
  select(country_name, country_text_id, year, all_of(my_indicator))

glimpse(my_data)

# 4) Plot over time (ggplot version)
library(ggplot2)
ggplot(my_data, aes(x = year, y = v2x_polyarchy, color = country_text_id)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", y = "v2x_polyarchy", title = "Trend in v2x_polyarchy")

