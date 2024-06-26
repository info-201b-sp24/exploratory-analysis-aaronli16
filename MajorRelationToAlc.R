
library(ggplot2)
library(dplyr)


data <- read.csv("https://drive.google.com/uc?export=download&id=1skt9wt6XkT1O8zBC3DKvZG988pnHKGC_")


names(data) <- c('Timestamp', 'Sex', 'Avg_GPA', 'Grade', 'Major',
                 'Avg_GPA_2023', 'Accommodation_Status', 'Monthly_Allowance',
                 'Scholarship_2023', 'Study_Hours_Per_Week', 'Party_Frequency',
                 'Drinks_Per_Night_Out', 'Classes_Missed_Per_Week',
                 'Classes_Failed', 'Romantic_Relationship', 'Parental_Approval_Alcohol',
                 'Relationship_With_Parents')


data$Major[data$Major == "" | is.na(data$Major)] <- "Undecided"


data$Major <- as.factor(data$Major)


print(unique(data$Drinks_Per_Night_Out))


clean_drinks <- function(x) {
  
  if (grepl("-", x)) {
    parts <- strsplit(x, "-")[[1]]
    return(mean(as.numeric(parts)))
  }

  if (grepl("\\+", x)) {
    return(as.numeric(gsub("\\+", "", x)))
  }
  
  return(as.numeric(x))
}


data$Drinks_Per_Night_Out <- sapply(data$Drinks_Per_Night_Out, clean_drinks)

summary(data$Drinks_Per_Night_Out)




average_drinks_per_major <- data %>%
  group_by(Major) %>%
  summarise(Average_Drinks = mean(Drinks_Per_Night_Out, na.rm = TRUE))


average_drinks_per_major$Major <- factor(average_drinks_per_major$Major, levels = unique(average_drinks_per_major$Major))

ggplot(average_drinks_per_major, aes(x = Major, y = Average_Drinks, fill = Major)) +
  geom_bar(stat = "identity", color = "black", show.legend = FALSE) +
  geom_text(aes(label = round(Average_Drinks, 2)), vjust = -0.5, size = 5) +  # Adjust text size and position
  theme_minimal() +
  labs(title = "Average Number of Drinks Consumed Per Night by Major ",
       x = "Major", y = "Average Drinks Per Night Out") +
  theme(axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        plot.title = element_text(size = 25, face = "bold"),
        axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 12)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10)) + 
  scale_fill_brewer(palette = "Pastel1")

