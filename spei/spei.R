## Packages

install.packages("SPEI")
library(SPEI)
library(readxl)
library(tidyverse)

# Example

data(wichita)
View(wichita)

spei1 <- spei(wichita, 1)

## Read data

temp <- read_excel("spei/Temperature Monthly Merged.xlsx", 13)

View(temp_tidy)

# Tidy data

temp_tidy <- pivot_longer(temp, 3:7, names_to = "region", values_to = "TMED")

# Lats of Bogura, Dinajpr, Ishwardi, Rajshahi, and Rangpur

temp_tidy$PET <- thornthwaite(temp_tidy$TMED, 
                              lat = 25)
