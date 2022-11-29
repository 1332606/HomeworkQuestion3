## import the data from melbourne dataset
melb_df <- read.table(
  file = "raw_data/melbourne.csv",
  header = TRUE,
  sep = ",",
  skip = 11)

## saving the mean rainfall for each month in melbourne in a numeric vector
mean_rainfall_melb <- as.numeric(melb_df[24,2:13])

## import the data from oxford dataset
ox_df <- read.table(
  file = "raw_data/oxford.txt",
  header = FALSE,
  col.names = c("year", "month", "x1", "x2", "x3", "rain", "x4"),
  skip = 7,
  na.strings = "---",
  nrows = 12 * (2020 - 1853))

## selecting the data from 1855-2015 for the oxford dataset
year_mask <- (1855 <= ox_df$year) & (ox_df$year <= 2015)
tmp <- ox_df[year_mask,c("month","rain")]
tmp$rain <- as.numeric(
  gsub(
    pattern = "\\*",
    replacement = "",
    x = tmp$rain))

## saving the mean rainfall for each month in oxford in a data frame
mean_rainfall_ox <- aggregate(
  x = tmp,
  by = list(month = tmp$month),
  FUN = mean)$rain

## input the names of the months into the "months" column of our data
months <- c(
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December")
  
## create the new data frame with the average monthly rainfall for each city
plot_df <- data.frame(
  month = rep(months, 2),
  month_num = rep(1:12, 2),
  location = rep(c("Melbourne", "Oxford"), each = 12),
  average_rainfall = c(mean_rainfall_melb, mean_rainfall_ox))

## saving the new table in the "processed_data" folder in the repository
write.table(x = plot_df,
            file = "processed_data/average-rainfall.csv",
            sep = ",",
            row.names = FALSE)
