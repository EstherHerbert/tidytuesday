# Packages ---------------------------------------------------------------------

library(tidyverse)

# Data -------------------------------------------------------------------------

(tt <- tidytuesdayR::tt_load("2023-12-19"))
list2env(tt, envir = .GlobalEnv)

# Graph ------------------------------------------------------------------------

holiday_episodes %>%
  mutate(
    highlight = abs(average_rating - parent_average_rating) >= 3
  ) %>%
  ggplot(aes(parent_average_rating, average_rating)) +
  geom_point(aes(col = highlight)) +
  geom_smooth(method = "lm", col = "yellow", fill = "yellow") +
  scale_colour_manual(values = c("white", "blue")) +
  labs(x = "Show Rating", y = "Episode Rating",
       title = "Christmas Episode Rating against overall show rating") +
  theme(legend.position = "none",
        panel.background = element_rect(fill = "#0B213C"),
        panel.border = element_blank(),
        plot.background = element_rect(fill = "#0B213C", colour = NA),
        line = element_blank(),
        axis.text = element_blank(),
        text = element_text(colour = "white", size = 12, face = "bold"))

ggsave(filename = "2023-12-19/20231219.png", width = 6, height = 4,
       units = "in")
