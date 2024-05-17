library(ggplot2)
library(dplyr)

data <- read.csv("/Users/aaronli/Downloads/Stats survey.csv")
View(data)
names(data) <- c('Timestamp', 'Sex', 'Avg GPA', 'Grade', 'Major',
                 'Avg_GPA_2023', 'Accommodation_Status', 'Monthly_Allowance',
                 'Scholarship_2023', 'Study_Hours_Per_Week', 'Party_Frequency',
                 'Drinks_Per_Night_Out', 'Classes_Missed_Per_Week',
                 'Classes_failed', 'Romantic_Relationship', 'Parental_Approval_Alcohol',
                 'Relationship_With_Parents')


data$Drinks_Per_Night_Out <- as.numeric(data$Drinks_Per_Night_Out, na.rm = FALSE)

avg_drinks_per_major <- data %>%
    group_by(Major) %>%
    summarise(Average_Drinks = mean(Drinks_Per_Night_Out, na.rm = TRUE))
