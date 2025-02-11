#Exploring data in R
#Ana Miller-ter Kuile
#January 14, 2025


# Load libraries ----------------------------------------------------------

#load the tidyverse and ratdat packages
library(tidyverse)
library(ratdat)


# Exploring dataframes ----------------------------------------------------

#let's explore that complete_old dataframe from the ggplot session

#what type of data is this complete_old dataframe
class(complete_old)

#what do the rows and columns of complete old look like?
head(complete_old)

tail(complete_old)

#let's provide arguments explicity and more arguments to the head
#function
head(x = complete_old, n = 10)

#we don't have to name arguments AS LONG AS they're in the right order
head(complete_old, 10)

#as long as you assign arguments explicitly, you can change their order
head(n = 10, x = complete_old)

#let's summarize this dataset
summary(complete_old)

#another summarizing function in R is the str()
str(complete_old)

#we can "pull out" a column of complete_old using the $ operator
complete_old$year

head(complete_old$year)


# Vectors -----------------------------------------------------------------

#let's make a vector with the c() function
c(1,2,5,12,6)

#let's save this vector as an object
num <- c(1,2,5,12,6)

#explore vectors with the class() function
class(num)

#let's make a character vecotr
char <- c("apple", "pear", "grape")

#class of char
class(char)

#logical vector
logi <- c(TRUE, FALSE, TRUE, T)

class(logi)


# Missing data ------------------------------------------------------------

#let's create a numeric vector with missing data
weights <- c(25, 34, 12, NA, 42)

#look at the minimum value of weights with the min() function
min(weights)

#let's change na.rm = TRUE argument
min(weights, na.rm = TRUE)


# Vectors from dataframes -------------------------------------------------

#let's look at the quantiles of the weight column in complete_old
quantile(complete_old$weight, probs = 0.25, na.rm = TRUE)

#let's look at more quantiles
quantile(complete_old$weight, probs = c(0.25, 0.5, 0.75), na.rm = TRUE)


# Other vector tricks -----------------------------------------------------

#shortcuts for creating vectors

#using the : operator
1:10

#using the seq() function to create these kinds of vectors
seq(from = 0, to = 1, by = 0.1)

#creatre a sequence vector of a certain length
seq(from = 0, to = 1, length.out = 20)

#rep() function to create longer vectors
rep("a", times = 4)




