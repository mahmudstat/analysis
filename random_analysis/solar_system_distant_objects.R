## Libraries

library(tidyverse)

sol_dist_obj <- read_csv("data/most_distant_solar_system_objects.csv")

View(sol_dist_obj)

## Remove unneeded columns and rows

sol_dist_obj <- sol_dist_obj[-c(1,91), c(1,5,6,7,8)]


## Also clean using bash 
## sed s/"(for comparison)"/""/ data/most_distant_solar_system_objects.csv 
## > data/obj2.csv

## Filter "∞Hyperbolic" out

sol_dist_obj <- sol_dist_obj %>% filter(Aphelion!="∞Hyperbolic")

## Did not work

## Remove by row sl

sol_dist_obj <- sol_dist_obj[-c(2,4,5,7),]

sol_dist_obj[1,5] <- NA

## Convert to numeric

sol_dist_obj <- cbind(sol_dist_obj[1], lapply(sol_dist_obj[2:5], as.numeric))

str(sol_dist_obj)

sol_dist_obj <- as_tibble(sol_dist_obj)

sol_dist_obj %>% ggplot(aes(Perihelion, Aphelion))+
  geom_point(color="blue")+
  geom_abline(intercept = 0, slope = 1)

# Just a check

sol_dist_obj %>% filter(Perihelion > Aphelion)

ggsave("random_analysis/output/corr.png")
