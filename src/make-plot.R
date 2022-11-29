## importing the libraries required
library(ggplot2)

## importing the combined data into a new data frame
plot_df <- read.csv("processed_data/average_rainfall.csv")

## plotting average monthly rainfall for each city
g <- ggplot(
  data = plot_df,
  mapping = aes(
    x = as.integer(month_num),
    y = average_rainfall,
    colour = location)) +
  geom_point() +
  geom_line() +
  labs(
    x = NULL,
    y = "Average rainfall (mm)",
    colour = "City",
    title = "Rainfall",
    subtitle = "Monthly average (1855--2015)") +
  scale_x_continuous(
    breaks = plot_df$month_num[seq(2,12,2)],
    labels = plot_df$month[seq(2,12,2)]) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = -45))

## saving the plot in the "out" folder in the repository
ggsave(filename = "out/result.png",
       plot = g,
       height = 10.5, width = 14.8,
       units = "cm")

## recording the session information
sink(file = "out/package-versions.txt")
sessionInfo()
sink()
