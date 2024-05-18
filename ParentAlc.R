library(ggplot2)
library(dplyr)

data <- read.csv("https://drive.google.com/uc?export=download&id=1skt9wt6XkT1O8zBC3DKvZG988pnHKGC_")
View(data)

names(data) <- c('Timestamp', 'Sex', 'Matric_Avg_GPA', 'Year', 'Major',
                 'Avg_GPA_2023', 'Accommodation_Status', 'Monthly_Allowance',
                 'Scholarship_2023', 'Study_Hours_Per_Week', 'Party_Frequency',
                 'Drinks_Per_Night_Out', 'Classes_Missed_Per_Week',
                 'Classes_failed', 'Romantic_Relationship', 'Parental_Approval_Alcohol',
                 'Relationship_With_Parents')

# Remove rows with blank or null values in the required columns
data <- data %>%
  filter(!is.na(Drinks_Per_Night_Out) & Drinks_Per_Night_Out != "",
         !is.na(Relationship_With_Parents) & Relationship_With_Parents != "",
         !is.na(Parental_Approval_Alcohol) & Parental_Approval_Alcohol != "")

# Convert categorical ranges to average numerical values
data <- data %>%
  mutate(Drinks_Per_Night_Out_Avg = case_when(
    Drinks_Per_Night_Out == "0" ~ 0,
    Drinks_Per_Night_Out == "1-3" ~ 2,
    Drinks_Per_Night_Out == "3-5" ~ 4,
    Drinks_Per_Night_Out == "5-8" ~ 6.5,
    Drinks_Per_Night_Out == "8+" ~ 10
  ))

data$Relationship_With_Parents <- as.factor(data$Relationship_With_Parents)
data$Parental_Approval_Alcohol <- as.factor(data$Parental_Approval_Alcohol)

ggplot(data, aes(x = Parental_Approval_Alcohol, y = Relationship_With_Parents, fill = Drinks_Per_Night_Out_Avg)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "red", name = "Avg. Drinks Per Night Out") +
  labs(title = "How Parents Affect Alcohol Consumption",
       x = "Parental Approval of Alcohol",
       y = "Relationship with Parents") +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.position = "bottom",
        legend.title = element_text(face = "bold")) +
  guides(fill = guide_legend(title.position = "top", title.hjust = 0.5)) +
  scale_y_discrete(limits = c("Fair", "Close", "Very close"))
