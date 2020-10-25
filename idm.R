library(tidyverse)
library(RColorBrewer)

idm <- read_csv("data/idm.csv") 

View(idm)

idm_tidy <- idm %>% pivot_longer(2:6, names_to = "region", values_to = "idm")

## Bogura

idm %>% ggplot(aes(x=Year, y = Bogura, group =1))+
  geom_line(size=0.9, color="blue")+
  labs(y="De Martonne Aridiy Index")+
  geom_smooth()


idm_tidy %>% filter(region=="Rajshahi") %>% 
  ggplot(aes(x=Year, y = idm))+
  geom_bar(stat="identity", fill="blue", width=0.7)+
  labs(y="De Martonne Aridiy Index")+
  geom_smooth(color="white")

col <- c("#54C495", "#3BBFB2", "#4CB6C7", "#75A9D0", "#9E9ACA")

dma <- function(r, col, col2){
  idm_tidy %>% filter(region==r) %>% 
    ggplot(aes(x=Year, y = idm, group =1))+
    geom_line(size=0.8, color=col)+
    labs(y="De Martonne Aridiy Index")+
  geom_smooth(color=col2)
  
  ggsave(filename = paste0("output/idm_",r,".png"), dpi = 300)
  
  ## Bar chart
  idm_tidy %>% filter(region==r) %>% 
    ggplot(aes(x=Year, y = idm))+
    geom_bar(stat="identity", fill=col, width=0.7)+
    labs(y="De Martonne Aridiy Index")+
    geom_smooth(color=col2)
  
  ggsave(filename = paste0("output/idm_bar_",r,".png"), dpi = 300)
}

dma("Rajshahi", col = "#54C495", col2 = "white")
dma("Bogura", col = "#3BBFB2", col2 = "white")
dma("Dinajpur", col = "#4CB6C7", col2 = "white")
dma("Ishwardi", col = "#75A9D0", col2 = "white")
dma("Rangpur", col = "#9E9ACA", col2 = "white")

idm_tidy %>% ggplot(aes(x=region, y=idm, color = "blue", fill=region))+
  geom_boxplot(show.legend = FALSE)+
  labs(x="", y="De Martonne Aridiy Index")+
  scale_fill_brewer(palette="PRGn")
ggsave("output/idm_box.png", dpi = 300)  

