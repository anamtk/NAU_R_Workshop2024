


# Making a plot of a correlation matrix among variables -------------------

#plotting package
#install.packages("corrplot")
library(corrplot)
#data package from LTER
#install.packages("lterdatasampler")
library(lterdatasampler)

#correlation matrix
data <- luq_streamchem %>%
  #remove non numerical data
  dplyr::select(-sample_id, -sample_date, -gage_ht) %>%
  #select columns that have a lot of data
  dplyr::select(temp:ca)

#make sure it works with making correlation (pearson)
#using "use = 'pairwise.complete.obs'" helps to bypass issues
#with NA values and evaluates only rows where combinations
#of values occur
cor(data, use = "pairwise.complete.obs")

#make the plot, by exploring
#?corrplot you can get some other options for how
#you want to plot to look
corrplot(cor(data, use = "pairwise.complete.obs"), 
         method = "number",
         type = "lower",
         diag = FALSE)

# Split a column into two columns -----------------------------------------

#split a column into two columns
fall24_am2 <- fall24_am %>%
  separate(scientific_name,
           into = c("genus", "species"),
           sep = " ",
           remove = TRUE)

#can use "unite" to do the opposite,
#explore ?unite to see what arguments you need

# Multiple lots in one ----------------------------------------------------

#put multiple plots in one plot
#patchwork package is awesome!
#install.packages("patchwork")
library(patchwork)

#make a couple of plots
plot2 <- ggplot(data, aes(x = temp, y = p_h)) +
  geom_point()

plot3 <- ggplot(data, aes(x = temp, y = cond)) +
  geom_point()

#put them together with patchwork 
#and change the way they look with
#plot_annotation and plot_layout
#find out more about these with
#?plot_annotation and 
#?plot_layout
plot2 + plot3 +
  plot_annotation(tag_levels = "a",
                  tag_suffix = ")") +
  plot_layout(widths = c(2,1))


# Convert time columns to "time" data -------------------------------------
library(lubridate)

#convert time data
data2 <- data %>%
  mutate(time = lubridate::hms(time))


# Joining datasets --------------------------------------------------------

#for example: one dataset that is observations of counts of different
#species at different pltos and dates, and one is cliamte data
#for those same plots and dates
#df1 - counts of species
#df2 - climate data
#id columns are plot and date

full_df <- df1 %>%
  left_join(df2, by = c("plot", "date"))

#if columns don't match across datasets, you have two options:
#use rename() function to make them consistent 
df1 %>%
  rename(Plot = plot,
         Date = date)

#or, give instructions in your join function
full_df <- df1 %>%
  left_join(df2, by = c("plot" = "Plot", "date" = "Date"))


# Get monthly climate data to average per site ----------------------------

#summarizing monthly data by site and year into cumulative/average
data2 <- data %>%
  group_by(Site, Year, Latitude, Longitude) %>%
  dplyr::summarize(cumulative_ppt = sum(ppt, na.rm = T),
                   mean_temp = mean(temp, na.rm = T),
                   min_temp = min(min_temp, na.rm = T),
                   max_temp = max(max_temp, na.rm = T)) %>%
  ungroup() 

#combine those climate data with response data on piñon needles
data_full <- needles %>%
  left_join(data2, by = c('Site','Year', 'Latitude', 'Longitude'))


