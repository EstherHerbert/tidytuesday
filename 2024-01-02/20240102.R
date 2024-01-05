# Packages ---------------------------------------------------------------------

library(tidyverse)
library(Strictly)

# Data -------------------------------------------------------------------------

# This week is bring your own data! I'm going to use the data from my Strictly
# package.

head(strictly)

# Wrangle ----------------------------------------------------------------------

strictly_bump <- strictly %>%
  filter(Year == "2023") %>%
  group_by(Week, Couple) %>%
  summarise(
    Total = sum(Total),
    Result = Result[1],
    .groups = "drop_last"
  ) %>%
  mutate(Rank = rank(-Total, ties.method = "random"))

colours <- scales::hue_pal()(length(unique(strictly_bump$Couple)))
names(colours) <- unique(strictly_bump$Couple)

ggplot(strictly_bump, aes(Week, Rank, col = Couple, group = Couple)) +
  ggbump::geom_bump(linewidth = 1.5) +
  geom_point(size = 2) +
  scale_y_reverse() +
  scale_colour_manual(values = colours) +
  geom_text(data = dplyr::filter(strictly_bump, Week == 1),
            aes(x = 0.9, y = Rank, label = Couple), col = "black", hjust = 1,
            fontface = "bold") +
  coord_cartesian(clip = "off") +
  theme_void() +
  theme(legend.position = "none", plot.margin = margin(l = 4, unit = "cm"))

ggsave("2024-01-02/20240102.png", width = 9, height = 4)
