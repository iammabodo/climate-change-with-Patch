library(tidyverse)

read_csv("data/GLB.Ts+dSSt.csv", skip = 1, na = "***") |> 
  select(year = Year, temp.difference = `J-D`) |> 
  ggplot(aes(x = year, y = temp.difference)) +
  geom_line(color = "gray", size = 1.5) +
  geom_point(fill = "white", color = "gray", shape = 21, size = 2) +
  geom_smooth(color = "black", se = F, span = 0.15, size = 1.5) +
  scale_x_continuous(breaks = seq(1880, 2025, 20), expand = c(0,0)) +
  scale_y_continuous(limits = c(-0.5, 1.5), expand = c(0,0)) +
  theme_light() +
  labs(x = "YEAR",
       y = "Temperature Anomaly (C)",
       title = "Global Temperatures Index",
       subtitle = "Data Source: NASA") +
  theme(
    axis.ticks = element_blank(),
    plot.title.position  = "plot",
    plot.title = element_text(margin = margin(b = 10), color = "red", face = "bold")
  )

ggsave("figures/temp_plot.png", height = 6, width = 6)
