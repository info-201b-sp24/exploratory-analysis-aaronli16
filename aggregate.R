library(ggplot2)
library(dplyr)

data <- read.csv("https://drive.google.com/uc?export=download&id=1skt9wt6XkT1O8zBC3DKvZG988pnHKGC_")

names(data) <- c('Timestamp', 'Sex', 'Matric_Avg_GPA', 'Year', 'Major',
                 'Avg_GPA_2023', 'Accommodation_Status', 'Monthly_Allowance',
                 'Scholarship_2023', 'Study_Hours_Per_Week', 'Party_Frequency',
                 'Drinks_Per_Night_Out', 'Classes_Missed_Per_Week',
                 'Classes_failed', 'Romantic_Relationship', 'Parental_Approval_Alcohol',
                 'Relationship_With_Parents')

# Convert 'Study_Hours_Per_Week' and 'Classes_Missed_Per_Week' to numeric values
data$Study_Hours_Per_Week <- as.numeric(gsub("\\+", "", data$Study_Hours_Per_Week))
data$Classes_Missed_Per_Week <- as.numeric(gsub("\\+", "", data$Classes_Missed_Per_Week))

data %>%
  group_by(Major) %>%
  summarise(
    `Average GPA` = round(mean(Avg_GPA_2023, na.rm = TRUE), 2),
    `Average Study Hours` = round(mean(Study_Hours_Per_Week, na.rm = TRUE), 1),
    `Average Classes Missed` = round(mean(Classes_Missed_Per_Week, na.rm = TRUE), 1),
    `Total Students` = n()
  ) %>%
  arrange(desc(`Average GPA`)) %>%
  select(Major, `Total Students`, `Average GPA`, `Average Study Hours`, `Average Classes Missed`)
