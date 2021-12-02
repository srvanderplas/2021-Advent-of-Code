library(tidyverse)

data <- readLines("day2ex")

trajectory <- tibble(dir = data) %>%
  mutate(horiz = ifelse(str_detect(dir, "forward|backward"), parse_number(dir), 0) * 
           ifelse(str_detect(dir, "forward"), 1, ifelse(str_detect(dir, "backward"), -1, 0))) %>%
  
  mutate(depth = ifelse(str_detect(dir, "up|down"), parse_number(dir), 0) * 
           ifelse(str_detect(dir, "up"), -1, ifelse(str_detect(dir, "down"), 1, 0)))

# Just checking
ggplot(trajectory, aes(x = cumsum(horiz), y = cumsum(depth))) + geom_step()

sum(trajectory$depth) * sum(trajectory$horiz)


# Part 2
# In addition to horizontal position and depth, 
# you'll also need to track a third value, aim, which also starts at 0. 
# The commands also mean something entirely different than you first thought:
# 
#     down X increases your aim by X units.
#     up X decreases your aim by X units.
#     forward X does two things:
#         It increases your horizontal position by X units.
#         It increases your depth by your aim multiplied by X.



trajectory <- tibble(dir = data) %>%
  mutate(X = ifelse(str_detect(dir, "forward"), parse_number(dir), 0),
         aim_del = ifelse(str_detect(dir, "up|down"), parse_number(dir), 0) * 
           ifelse(str_detect(dir, "up"), -1, ifelse(str_detect(dir, "down"), 1, 0)),
         aim = cumsum(aim_del),
         depth_del = aim * X) %>%
  mutate(horiz = cumsum(X)) %>%
  mutate(depth = cumsum(depth_del))

# Just checking
ggplot(trajectory, aes(x = cumsum(horiz), y = cumsum(depth))) + geom_step()

trajectory$depth[nrow(trajectory)] * trajectory$horiz[nrow(trajectory)]
