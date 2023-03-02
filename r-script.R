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



