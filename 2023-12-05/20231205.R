# Packages ---------------------------------------------------------------------

library(tidyverse)
library(gganimate)

# Data -------------------------------------------------------------------------

tt <- tidytuesdayR::tt_load("2023-12-05")

list2env(tt, envir = .GlobalEnv)

# Wrangling --------------------------------------------------------------------

anim <- life_expectancy %>%
  filter(Entity %in% c("England and Wales", "Scotland", "Northern Ireland")) %>%
  group_by(Year) %>%
  mutate(
    rank = rank(-LifeExpectancy, ties.method = "first"),
    LfeExpectancy_rel = LifeExpectancy/LifeExpectancy[rank==1]
  ) %>%
  ungroup() %>%
  ggplot(aes(rank, group = Entity, fill = Entity, color = Entity)) +
  geom_tile(aes(y = LifeExpectancy/2,
                height = LifeExpectancy,
                width = 0.9), alpha = 0.8, color = NA) +
  geom_text(aes(y = 0, label = paste(Entity, " ")), vjust = 0.2, hjust = 1, size = 6) +
  geom_text(aes(y = LifeExpectancy, label = LifeExpectancy, hjust = 0), size = 6) +
  coord_flip(clip = "off", expand = FALSE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  guides(color = FALSE, fill = FALSE) +
  transition_states(Year, transition_length = 4, state_length = 1) +
  labs(title = 'Year: {closest_state}')

animate(anim, 200, fps = 20,  width = 1200, height = 1000)
