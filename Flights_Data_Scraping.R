install.packages("rvest")
library(rvest)
library(dplyr)
?dplyr

? read_html
flights <- read_html('https://en.wikipedia.org/wiki/Non-stop_flight') %>% 
  html_nodes('.wikitable') %>% 
  .[[1]] %>% 
  html_table(fill = TRUE)

names(flights) <- c("rank", "from", "to", "airline", "flight_no", "distance",
                    "duration", "aircraft", "first_flight")
# cells spanning multiple rows
(row_no <- which(is.na(flights$first_flight)))
problem_rows <- flights[row_no, ]
fixed_rows <- flights[row_no - 1, ]
fixed_rows$rank <- problem_rows[, 1]
fixed_rows$airline <- problem_rows[, 2]
fixed_rows$flight_no <- problem_rows[, 3]
fixed_rows$duration <- problem_rows[, 4]
fixed_rows$aircraft <- problem_rows[, 5]
flights <- flights[-row_no, ]
flights <- rbind(flights, fixed_rows) %>% 
arrange(rank)

head (flights)
