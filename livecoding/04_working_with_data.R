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






