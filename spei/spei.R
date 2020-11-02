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

## Read Rainfall data

rain <- read_excel("spei/Rainfall Monthly Merged.xlsx", 13)

rain$Year <- temp$Year

View(rain_tidy)

rain_tidy <- pivot_longer(rain, 3:7, names_to = "region", values_to = "PRCP")

spei_df <- temp_tidy[,c(1,2,5:7)]
spei_df$PRCP <- rain_tidy$PRCP

## Estimate water balacne (WB)

spei_df$WB <- spei_df$PRCP - spei_df$PET

# Calculate SPEI

# Convert to Time Series

spei_ts <- ts(spei_df[, -c(1,2)], end = c(2016, 12), frequency = 12)

spei12 <- spei(spei_df[, "WB"], 12)

View(spei12$fitted)

View(spei12)


spei_out <- data.frame(spei12$fitted)

spei_out$ Year <- rep(1966:2016, 5)

months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

spei_out$Month <- rep(months, each=5*51)

reg <- c("Bogura", "Dinajpr", "Ishwardi", "Rajshahi", "Rangpur")

spei_out$Region <- rep(reg, times = 612)

## Plot

spei_out %>% ggplot(aes(x=Year, y = WB, color = Region))+
  geom_line(group=1)+
  facet_wrap(~Month)

## Find average spei

spei_avg <- spei_out %>% group_by(Year, Month) %>% 
  summarise(avg = mean(WB))

spei_avg %>% ggplot(aes(Year, avg, color = Month))+
  geom_line(group=1)+
  facet_wrap(~Month)

## Lock order

spei_avg$Month <- factor(spei_avg$Month, levels = months)
