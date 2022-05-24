library(tidyverse)
library(glue)

temp.data <- read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***") |> 
  select(year = Year, temperature.diff = `J-D`) |> 
  drop_na() 

annotation <- temp.data|>
  slice(1, n()) |>
  arrange(year) |> 
  mutate(temperature.diff = 0,
         x = year + c(-10, 10))

temp.data |> ggplot(aes(x = year, 
                        y = temperature.diff,
                        fill = temperature.diff)) +
  geom_col(show.legend = F) +
  geom_text(data = annotation, 
            aes(label = year,
                x = x), color = "white") +
  geom_text(x = 1880, y = 1, hjust = 0, 
            label = glue("Global Tempreratures have risen by {max(temp.data$temperature.diff)}\u00B0C since {min(temp.data$year)}"),
            colour  = "white") +
  # scale_fill_gradient2(low = "darkblue", 
  #                     mid = "white", 
  #                     high = "darkred",
  #                     midpoint = 0) +
  scale_fill_stepsn(colours = c("darkblue", 
                                   "white",
                                   "darkred"),
                       values = scales::rescale(c(min(temp.data$temperature.diff),
                                          0,
                                          max(temp.data$temperature.diff))),
                       limits = c(min(temp.data$temperature.diff),
                                  max(temp.data$temperature.diff)),
                    n.breaks =10) +
  theme_void() +
  theme(
    plot.background = element_rect(fill = "black")
  )

ggsave("figures/temperature_bar_plot.png", width = 6, height = 6)
