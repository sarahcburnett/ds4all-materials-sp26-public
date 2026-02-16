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

#install.packages(c('tidyverse','janitor','wbstats'))
# only need to do this once on your computer

# ## Setup

# Load packages
library(wbstats)  # for downloading WB data
library(dplyr)    # for selecting, renaming and mutating
library(janitor)  # for rounding

# ## Searching for WB Indicators

life_indicators<- wb_search("life expectancy")   # Search for life expectancy
print(life_indicators, n = 20)                    # Show first 20 results

# Want: Individuals using the Internet (% of population)
internet_indicators <- wb_search("internet")      # Search for internet usage
print(internet_indicators, n = 20)                # Show first 20 results

# Don't see what you're looking for? Try:
# View(internet_indicators)

# It's easier to search these things in Rstudio.

# ## `wbstats` Example

# Store the list of indicators in an object
indicators <- c(
  life_exp       = "SP.DYN.LE00.IN",
  internet_users = "IT.NET.USER.ZS"
)

# Download the data
wb_data_clean <- wb_data(indicators, mrv = 30) |>
  select(!iso2c) |>          # Drop the 2-letter country code (not needed)
  rename(year = date) |>     # Rename 'date' column to 'year'
  mutate(
    life_exp       = round_to_fraction(life_exp, denominator = 10),      # ~0.1 precision
    internet_users = round_to_fraction(internet_users, denominator = 100) # ~0.01 precision
  )

# View the structure of the dataset
glimpse(wb_data_clean)

# ## Try it out!
#
# - Search for a WB indicator
# - Download the data
#

