# Day 1
library(magrittr)
depths <- readLines("day1") %>% as.numeric()
sum(diff(depths) > 0)

library(zoo)
depth_3 <- rollapply(depths, sum, width = 3)
sum(diff(depth_3) > 0)
