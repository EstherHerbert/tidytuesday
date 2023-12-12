# Packages ---------------------------------------------------------------------

library(tidyverse)
library(gganimate)

# Data -------------------------------------------------------------------------

tt <- tidytuesdayR::tt_load("2023-12-12")
list2env(tt, envir = .GlobalEnv)

# Wrangle ----------------------------------------------------------------------

holiday_movie_genres %>%
  filter(genres %in% c("Comedy", "Drama", "Romance", "Family", "Animation",
                       "Fantasy", "Adventure", "Documentary", "Short",
                       "Music")) %>%
  left_join(select(holiday_movies, tconst, year), by = "tconst") %>%
  count(year, genres) %>%
  group_by(year) %>%
  mutate(
    rank = rank(-n, ties.method = "random")
  ) %>%
  filter(year == 2020) %>%
  ggplot(aes(y = factor(rank), fill = genres)) +
  geom_col(aes(x = n), alpha = 0.8) +
  geom_text(aes(x = 0, label = genres, col = genres))
