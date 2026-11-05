# Importing data activity
# Download this from the containing folder 'importing'
# to try in Rstudio.

# Vocabulary
# - Folder / directory: a container for files.
# - Path: directions to a file (example: `data_from_client/banknote.csv`).
# - Working directory: the folder R uses as "here" when you write a relative path.
# - Relative path: a path that starts from the working directory.
# - Absolute path: a full path starting from the root of the computer
#   (we avoid these for class projects).

# ---- Checkpoint ----
# 1. We will be setting relative paths.
# 2. In your file browser, find that same folder.
#
# Note: You are starting at `activity.R`.

# ---- Part 1: Explore the data folder ----
# Your project folder `lec8/` contains folders and files like:
#
# demo/
#   activity.R
#   data_from_client/
#     data/
#       baby (1).csv
#     my_data_for_YOU/
#       data/
#         actors.csv
#     banknote.csv
# DATA/
#   united_summer2015.csv


# ---- Load tidyverse libraries ----

# Read in readr to read the csv's with read_csv
library(readr)

# Library for plotting
library(ggplot2)


# ---- Task 1 ----
# Read `baby (1).csv` by finding the relative path.
# - Store it as a variable named `baby`
# - Print the first 6 rows

baby <- read_csv('...')
head(baby)

ggplot(baby, aes(x = `Birth Weight`)) +
  geom_histogram() +
  labs(
    title = "Distribution of birth weight",
    x = "Birth weight (units as recorded)",
    y = "Count"
  ) +
  theme_minimal()


# ---- Task 2 ----
# Read `actors.csv` by finding the relative path.
# - Store it as a variable named `actors`
# - Print the column names

actors <- read_csv('...')
names(actors)

ggplot(actors, aes(x = `Number of Movies`, y = `Total Gross`)) +
  geom_point() +
  labs(
    title = "Total gross vs number of movies",
    x = "Number of movies",
    y = "Total gross (millions)"
  ) +
  theme_minimal()


# ---- Task 3 ----
# Read `united_summer2015.csv` by finding the relative path.
# Hint: To go outside your directory, use `../`.
# - Store it as a variable named `u`

u <- read_csv("...")
library(dplyr) # for glimpse() and mutate()
glimpse(u)

library(lubridate)  # to encode the dates

u_daily <- u |>
  mutate(Date = mdy(Date)) |>
  group_by(Date) |>
  summarize(mean_delay = mean(Delay))

glimpse(u_daily)
ggplot(u_daily, aes(x = Date, y = mean_delay)) +
  geom_line() +
  labs(
    title = "United flights: average delay by day (Summer 2015)",
    x = "Date",
    y = "Average delay (minutes)"
  ) +
  theme_minimal()