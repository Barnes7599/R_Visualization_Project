#recreating graph from the economist located at https://www.economist.com/graphic-detail/2011/12/02/corrosive-corruption

library(tidyverse)
library(ggthemes)

#import the data
economist <- read_csv("Economist_Assignment_Data.csv")
head(economist)

ggplot(economist, aes(CPI, HDI, color = Region)) +
    geom_point(shape = 1, size = 4) + 
    # since color is by a categorical variable you will need to group so that the trendline goes between all data sets and not through each categorical variable
    #method "lm" is linear regression
    # formula y ~ log(x) plots the log of variable x (curved line)
    geom_smooth(aes(group = 1), method = "lm", formula = y ~ log(x), se = FALSE, color = "red", size = .5) +
    # since we want to label each variable we will have to use the aes() function
    geom_text(aes(label = Country), color = "gray20", data = subset(economist, Country %in% pointsToLabel), check_overlap = TRUE) +
    labs(x = "Corruption Perception Index, 2011 (10=least corrupt", y = "Human Development Index, 2011 (1=best)", title = "Corruption and Human Developmemt", caption = "Source: Transparency International; UN Human Development Report") +
    theme_economist_white() +
    theme(legend.position = "top", plot.title = element_text(face = "bold"), plot.caption = element_text(hjust = 0)) +
    scale_y_continuous(limits = c(.2,1.0)) +
    scale_x_continuous(limits = c(1,10), breaks = 1:10)
    
    
# need to add labels via subset 
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")
   
     


