# Packages ---------------------------------------------------------------------

library(tidyverse)

# Data -------------------------------------------------------------------------

tt <- tidytuesdayR::tt_load("2023-12-12")
list2env(tt, envir = .GlobalEnv)

# Wrangle ----------------------------------------------------------------------

holiday_movies <- holiday_movies %>%
  filter(christmas | holiday) %>%
  mutate(
    christmas_holiday = if_else(christmas, "Christmas", "Holiday")
  )

# Plot -------------------------------------------------------------------------

holiday_movies %>%
  ggplot(aes(year, fill = christmas_holiday)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("red", "forestgreen")) +
  scale_x_continuous(n.breaks = 10) +
  labs(fill = "", x = "Year", y = "Count",
       title = "The use of \"Christmas\" or \"Holiday\" over the years") +
  theme_minimal() +
  theme(legend.position = "bottom",
        title = element_text(size = 16, face = "bold"),
        plot.background = element_rect(fill = "floralwhite"))
