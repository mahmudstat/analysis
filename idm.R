library(tidyverse)

idm <- read_csv("data/idm.csv") 

View(idm)

idm_tidy <- idm %>% pivot_longer(2:6, names_to = "region", values_to = "idm")

## Bogura

idm %>% ggplot(aes(x=Year, y = Bogura, group =1))+
  geom_line(size=1.2, color="red")+
  labs(y="De Martonne Aridiy Index")
