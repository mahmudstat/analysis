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

write_excel_csv(writing_rank, "compt2.csv")


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
  arrange(Species, rank) 

## Group by max

iris %>% group_by(Species) %>% 
  summarise(max = max(Sepal.Length))

## Group by top three

iris %>% arrange(desc(Sepal.Length)) %>% 
  group_by(Species) %>% slice(1:4)

writing_compt %>% arrange(desc(Percentage)) %>% 
  group_by(category) %>% slice(1:3) %>% View()
