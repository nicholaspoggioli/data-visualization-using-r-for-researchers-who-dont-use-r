# Data visualization in R for researchers who don't use R

library(tidyverse)
library(patchwork)

# Load data
dat <- read_csv(file = "ldt_data.csv")

# Summarize
summary(dat)
str(dat)

# Correct language column
dat <- mutate(dat, language = factor(
  x = language, # column to translate
  levels = c(1, 2), # values of the original data in preferred order
  labels = c("monolingual", "bilingual") # labels for display
))

# Summarizing data
dat %>% 
  group_by(language) %>% # group observations by language
  count() %>% # count members of each group
  ungroup() # ungroup the data

dat %>% 
  summarise(mean_age = mean(age), # calculate the average age
            sd_age = sd(age), # calculate the standard deviation of age
            n_values = n()) # calculate the number of observations
dat %>% 
  group_by(language) %>% 
  summarise(mean_age = mean(age),
            sd_age = sd(age),
            n_values = n()) %>% 
  ungroup()

# Bar chart
ggplot(data = dat, # specify the data
       mapping = aes(x = language)) + # maps variable 'language' to aesthetic 'x'
  geom_bar() # use a bar plot

# Aggregates and percentages
dat_percent <- dat %>% # create new variable 'dat_percent' from existing variable 'dat'
  count(language) %>% # count rows per value of 'language' and store result in new column 'n'
  mutate(percent = (n/sum(n)*100)) # create new column 'percent' using calculation after '='

ggplot(dat_percent,
       aes(x = language, y = percent)) +
  geom_bar(stat="identity")

# Histogram
ggplot(data = dat,
       aes(x = age)) +
  geom_histogram()

# Plot customizations

## Histogram bin width
ggplot(data = dat,
       aes(x = age)) +
  geom_histogram(binwidth = 5) # customize histogram bin width

## Colors
ggplot(data = dat,
       aes(x = age)) +
  geom_histogram(binwidth = 1,
                 fill = "black",
                 color = "white")

## Axis names and labels
ggplot(data = dat,
       aes(x = language)) +
  geom_bar() +
  scale_x_discrete(name = "Language group", # Specifies x-axis is a discrete variable
                   labels = 
                     c("Monolingual",
                       "Bilingual")) +
  scale_y_continuous(name = "Number of participants", # Specifies y-axis variable is a continuous variable
                     breaks = c(0,10,20,30,40,50))

