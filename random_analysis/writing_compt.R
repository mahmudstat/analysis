## Libraries

library(tidyverse)
library(readxl)

writing_compt <- read_csv("data/writing_compt.csv", n_max = 96)

View(writing_compt)

writing_rank <- writing_compt %>%  arrange(category) %>% 
  group_by(category) %>% 
  mutate(Grouped_Rank=rank(-Percentage, ties.method = "average")) %>% 
  arrange(category, Grouped_Rank)

View(writing_rank)

?write_excel_csv()


## Test 
set.seed(10)
dat <- tibble(x=sample(20,10))

dat %>% mutate(rank=rank(x)) %>% arrange(desc(rank)) %>% 
  mutate(rank2 = 1:length(rank))

sort(dat$x, decreasing = TRUE)

dat %>% arrange(desc(x))

iris

iris %>% arrange(Species, Sepal.Length) %>% 
  group_by(Species) %>% 
  mutate(rank = rank(-Sepal.Length, ties.method = "average")) %>% 
  arrange(rank)


# Group by max/min

iris %>% group_by(Species) %>% 
  summarise(max = max(Sepal.Length))

