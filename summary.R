library(ggplot2)
library(dplyr)

data <- read.csv("https://drive.google.com/uc?export=download&id=1skt9wt6XkT1O8zBC3DKvZG988pnHKGC_")

names(data) <- c('Timestamp', 'Sex', 'Matric_Avg_GPA', 'Year', 'Major',
                 'Avg_GPA_2023', 'Accommodation_Status', 'Monthly_Allowance',
                 'Scholarship_2023', 'Study_Hours_Per_Week', 'Party_Frequency',
                 'Drinks_Per_Night_Out', 'Classes_Missed_Per_Week',
                 'Classes_failed', 'Romantic_Relationship', 'Parental_Approval_Alcohol',
                 'Relationship_With_Parents')

summary_info <- list()
summary_info$num_rows <- nrow(data)

summary_info$highest_allowance <- max(data$Monthly_Allowance)

summary_info$avg_gpa <- mean(data$Avg_GPA_2023, na.rm = TRUE)

summary_info$alcohol_related_misses <- sum(data$Classes_Missed_Per_Week > 0 & data$Drinks_Per_Night_Out > 0)

summary_info$num_in_relationship <- sum(data$Romantic_Relationship == "Yes")
