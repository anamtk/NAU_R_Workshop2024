library(tidyverse)
library(lterdatasampler)
theme_set(theme_bw())

#Fiddler crab body size recorded summer 2016 in salt marshes
#from Florida to Massachusetts including Plum Island Ecosystem 
#LTER, Virginia Coast LTER, and NOAA’s National Estuarine 
#Research Reserve System

#get the crabs dataset
crabs <- pie_crab

crabs2 <- crabs %>%
  filter(latitude %in% c(30.0, 34.0, 42.7, 41.6, 37.2)) %>%
  mutate(site = case_when(site == "VCR" ~ "CR",
                          TRUE ~ site))

ggplot(crabs2, aes(x = site, y = size)) +
  geom_boxplot() +
  labs(x = "Survey site",
       y = "Carapace width (mm)")

ggplot(crabs2, aes(x = site, y = latitude)) +
  geom_point()+
  labs(x = "Survey site",
       y = "Latitude")

model <- lm(size ~ site, 
            data = crabs2)

summary(model)

crabs3 <- crabs2 %>%
  mutate(site = factor(site, levels = c("GTM", "ZI", "CR", "NB", "PIE")))

ggplot(crabs3, aes(x = site, y = size)) +
  geom_boxplot()+
  labs(x = "Survey site",
       y = "Carapace width (mm)")

model2 <- lm(size ~ site, 
            data = crabs3)

summary(model2)
