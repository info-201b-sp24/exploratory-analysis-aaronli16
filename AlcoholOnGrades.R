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

data$Drinks_Per_Night_Out <- as.factor(data$Drinks_Per_Night_Out)

ggplot(data, aes(x = Drinks_Per_Night_Out, y = Avg_GPA_2023, fill = Drinks_Per_Night_Out)) +
  geom_boxplot(outlier.shape = 16, outlier.size = 2, notch = TRUE) +
  scale_fill_brewer(palette = "Pastel1") +
  labs(title = "Impact of Alcohol Consumption on Grades",
       x = "Drinks Per Night Out",
       y = "Average GPA (2023)",
       fill = "Drinks Per Night Out") +
  theme_minimal(base_size = 15) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, face = "italic"),
        legend.position = "bottom",
        legend.title = element_text(face = "bold")) +
  guides(fill = guide_legend(title.position = "top", title.hjust = 0.5))
