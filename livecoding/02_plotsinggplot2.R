#Ana Miller-ter Kuile
#January 7, 2025
#Exploring graphs with ggplot2

# Load our packages -------------------------------------------------------

#load our installed packages that we need
library(tidyverse) 
#ggplot2 is a package inside the tidyverse package

#load the package that has the data we're plotting
library(ratdat)

#we are going to be plotting the complete_old
#dataset from the ratdat package

?complete_old

#look at dataset like an Excel spreadsheet
View(complete_old)

#use the str() function to learn more about data types
str(complete_old)


# Intro to ggplot ---------------------------------------------------------


#introduce ourselves to this ggplot() function
ggplot(data = complete_old)

#we will add mapping argument to look at the relationship
#between hindfoot_length and weight
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length))

#let's tell ggplot what kind of graph we want -
#we want a scatterplot
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()


# Adding aesthetics -------------------------------------------------------

#change aesthetics on this plot in a few ways

#first, let's make the points semi-transparent so that 
#we can see where there are clusters 
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2)

#second, let's add some color!
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, color = "blue")

ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, color = "#f0027f")

#change the color of points by a category
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length, color = plot_type)) +
  geom_point(alpha = 0.2)

# Changing scales ---------------------------------------------------------


#I want a better color ramp for my groups
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length, color = plot_type)) +
  geom_point(alpha = 0.2) +
  scale_color_viridis_d() 


# Change background theme -------------------------------------------------

ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length, color = plot_type)) +
  geom_point(alpha = 0.2) +
  scale_color_viridis_d() +
  theme_bw()

# Boxplots! ---------------------------------------------------------------

#let's look at differences in plot types with a boxplot
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_boxplot()

#add color to my boxplot
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length, color = plot_type)) +
  geom_boxplot()

#rather than changing the outlines to be colored, let's "fill"
#our boxplots by plot type
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length, fill = plot_type)) +
  geom_boxplot()


# Adding geoms together ---------------------------------------------------

ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_boxplot() +
  geom_point(alpha = 0.2)

#add jitter to points so we can see them better 
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.2)

#add color to both the points and boxplots
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length, color = plot_type)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.2)

#adding color to only the points
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_boxplot() +
  geom_jitter(mapping = aes(color = plot_type), alpha = 0.2)


# Assigning objects -------------------------------------------------------

#create an object that is my plot
myplot <- ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_boxplot() +
  geom_jitter(mapping = aes(color = plot_type), alpha = 0.2)

myplot

#add things to our myplot object
myplot + 
  theme_bw()

#change axis labels
myplot +
  theme_bw() +
  theme(axis.title = element_text(size = 14)) +
  labs(title = "Rodent sizes by plot type", x = "Plot type", y = "Hindfoot length (mm)")


# Exporting plots ---------------------------------------------------------

#create another object that is the final plot to save
finalplot <-  myplot +
  theme_bw() +
  theme(axis.title = element_text(size = 14)) +
  labs(title = "Rodent sizes by plot type", x = "Plot type", y = "Hindfoot length (mm)")

#use the ggsave function to save this plot on our computer
ggsave(filename = 'images/rodent_size_plot.jpg', plot = finalplot, height = 6, width = 8)
