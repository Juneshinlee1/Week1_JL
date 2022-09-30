# Week 1 R and Coding Assignment

# Load the libraries 
library(tidyverse)
library(haven)

#Load the data
nfhs <- read_dta("IAHR52FL.dta")
#Subset the data
nfhs <- select(nfhs,hhid:shstruc)

# Distribution plot number of household members
ggplot(data = nfhs)+
  geom_histogram(mapping = aes(x = hv009), binwidth =1)

# New df with only urban household 

urban_df <- filter(nfhs,hv025 == 1)

view(urban_df)

# Using factors to turn hv025 into a categorical variable

hv026_fct <- as.factor(urban_df$hv026)


# Renaming factor levels
levels(hv026_fct) <- c("Capital, Large city","Small city","Town","Countryside","Missing")

# Box Plot distribution of household size by type of urban area

ggplot(data = urban_df, mapping = aes(x = hv026_fct, y = hv009))+
  geom_boxplot() + xlab('Type of Urban Area') + ylab('Household Size')

# Summarize means, median of # of household members by type of urban area

urban_df %>%
  group_by(hv026) %>%
  summarise(
    mean = mean(hv009), median = median(hv009)
  )
