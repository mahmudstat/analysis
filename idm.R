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

## All in one plot

idm_tidy %>% ggplot(aes(x=Year, y = idm, color = region, group=1))+
  geom_smooth(method = "loess", level = 0.99)+
  geom_line(size=0.8)+
  facet_wrap(~region, nrow=3)+
  labs(y="De Martonne Aridiy Index")+
  scale_color_manual(values = c("#CE2FF6", "#710FB0", 
                               "#4A5FD2", "#4EB00F", "#24116F"))+
  theme(legend.position = "none")

ggsave("output/idm_all_facet.png", dpi = 300)


## All lines in same graph

idm_tidy %>% ggplot(aes(Year, idm, color = region))+
  geom_line(size=0.8)+
  labs(y="De Martonne Aridiy Index")+
  scale_color_brewer(palette="Set1")+
  geom_point()+
  theme(legend.position = "top")

ggsave("output/idm_all.png", dpi = 300)

## Area Chart

idm_tidy %>% ggplot(aes(Year, idm, fill = region))+
  geom_area(size=0.8)+
  labs(y="De Martonne Aridiy Index")+
  scale_fill_brewer(palette="Paired")+
  theme(legend.position = "top")

ggsave("output/idm_area.png", dpi = 300)

## Boxplot 

idm_tidy %>% ggplot(aes(x=region, y=idm, color = "blue", fill=region))+
  geom_boxplot(show.legend = FALSE)+
  labs(x="", y="De Martonne Aridiy Index")+
  scale_fill_brewer(palette="PRGn")
ggsave("output/idm_box.png", dpi = 300) 



