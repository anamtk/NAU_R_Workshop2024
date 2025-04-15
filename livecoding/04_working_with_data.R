#Working with data in R
#Ana Miller-ter Kuile
#February 11, 2025

#this is a script introducing how to import and manipulate data in R

#load the library for the tidyverse
library(tidyverse)


# Import data -------------------------------------------------------------

surveys <- read_csv('data/cleaned/surveys_complete_77_89.csv')

#what is the class of surveys
class(surveys)


# Manipulating data -------------------------------------------------------

#use the select() function to choose columns of interest
select(surveys, plot_id, species_id, hindfoot_length)

#exclude columsn using the select function
select(surveys, -record_id, -year)

#select columns based on the order in the dataframe
select(surveys, c(3:5, 10))

#select columns that have missing data
select(surveys, where(anyNA))

#use the filter() function to seelct rows that fit our criteria
filter(surveys, year == 1985)

#other operators that are useful:
# > greater than
# < less than
# >= greater or equal to
# <= less than or eqaul to
# != not equal to

#another useful operator is the %in% operator
filter(surveys, species_id %in% c("RM", "DO"))

#use multiple operators at once
filter(surveys, year <= 1998 & !is.na(hindfoot_length))


# Putting functions together into one step with the pipe ------------------

#nest functions to put them together
filter(select(surveys, -day), month>=7)

#or you could create intermediate objects
surveys_noday <- select(surveys, -day)
filter(surveys_noday, month >= 7)

#let's use the pipe operator instead!
# %>%
surveys %>%
  select(-day) %>%
  filter(month >= 7)

surveys_sub <- surveys %>%
  select(-day) %>%
  filter(month >= 7)


# Adding new columns with mutate() ----------------------------------------

#add a new column of weight in kg using mutate()
surveys %>%
  mutate(weight_kg = weight/1000)

#you can add multiple columns in one mutate function
surveys %>%
  mutate(weight_kg = weight/1000,
         weight_lbs = weight_kg*2.2)

#using multiple columns in a mutate function
surveys %>%
  mutate(date = paste(year, month, day, sep = "-")) 

library(lubridate)

#make the date column "date" data in R
surveys %>%
  mutate(date = paste(year, month, day, sep = "-"),
         date = ymd(date)) %>%
  #define the package you want the function to come from
  #to avoid issues with functions in multiple packages
  dplyr::select(date, day)


# Split-Apply-Combine data ------------------------------------------------

#group_by()

#summarize() 

#average size by species of rodents
surveys %>%
  #split dataframe with the group_by() function
  group_by(species_id) %>%
  #look at mean weights by group
  summarize(mean_weight = mean(weight, na.rm = T),
            sd_weight = sd(weight, na.rm = T))

#remove NA values and then get summaries
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species_id) %>%
  summarise(mean_weight = mean(weight, na.rm =T),
            sd_weight = sd(weight, na.rm = T),
            total = n(),
            se_weight = sd_weight/sqrt(total))

#group by multiple variables
rodent_spsx <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>%
  dplyr::summarize(mean_weight = mean(weight, na.rm = T),
                   sd_weight = sd(weight, na.rm = T),
                   total = n(),
                   se_weight = sd_weight/sqrt(total)) %>%
  ungroup()


# Reshaping data with tidyr -----------------------------------------------

sp_by_plot <- surveys %>% 
  filter(!is.na(weight)) %>%
  group_by(species_id, plot_id) %>%
  summarize(mean_weight = mean(weight, na.rm = T))

#make a "wide" format of this with plots as columns
sp_by_plot_wide <- sp_by_plot %>%
  pivot_wider(names_from = plot_id,
              values_from = mean_weight)

#make wide "long" again
sp_by_plot_wide %>%
  pivot_longer(cols = -species_id,
               names_to = "plot_id",
               values_to = "mean_weight")

# Exporting data ----------------------------------------------------------

write_csv(sp_by_plot, "data/cleaned/surveys_weight_species_plot.csv")







