#### Preamble ####
# Purpose: Cleans the raw fire incidents data recorded by toronto
# Author: Qisheng Yu
# Date: 20 Sep 2024
# Contact: qisheng.yu@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read.csv("../data/raw_data/raw_data.csv")
glimpse(raw_data)

library(lubridate)  


cleaned_data <- raw_data %>%
  mutate(
    TFS_Alarm_Time = ymd_hms(TFS_Alarm_Time),  # Convert alarm time to datetime format
    TFS_Arrival_Time = ymd_hms(TFS_Arrival_Time),  # Convert arrival time to datetime format
    Response_Time = as.numeric(difftime(TFS_Arrival_Time, TFS_Alarm_Time, units = "mins"))  # Calculate response time in minutes
  )


cleaned_data <- cleaned_data %>%
  select(
    Incident_ID = X_id,  # Unique identifier for the incident
    Incident_Type = Final_Incident_Type,  # Type of incident
    Response_Time,  # Calculated response time in minutes
    Estimated_Loss = Estimated_Dollar_Loss,  # Estimated financial loss
    Civilian_Casualties = Civilian_Casualties,  # Number of civilian casualties
    Firefighter_Casualties = TFS_Firefighter_Casualties,  # Number of firefighter casualties
    Persons_Rescued = Count_of_Persons_Rescued,  # Number of people rescued
    Fire_Alarm_Operation = Fire_Alarm_System_Operation,  # Operation status of fire alarm system
    Fire_Alarm_Presence = Fire_Alarm_System_Presence,  # Presence of fire alarm system
    Area_of_Origin = Area_of_Origin,  # Origin area of the fire
    Extent_of_Fire = Extent_Of_Fire,  # Extent of the fire
    Incident_Station_Area = Incident_Station_Area,  # Station area where the incident occurred
    Incident_Ward = Incident_Ward,  # Ward where the incident occurred
    Latitude = Latitude,  # Latitude of the incident
    Longitude = Longitude,  # Longitude of the incident
    Responding_Units = Number_of_responding_apparatus,  # Number of responding units
    Responding_Personnel = Number_of_responding_personnel  # Number of responding personnel
  )


cleaned_data <- cleaned_data %>%
  mutate(
    Estimated_Loss = ifelse(is.na(Estimated_Loss), median(Estimated_Loss, na.rm = TRUE), Estimated_Loss),
    Response_Time = ifelse(is.na(Response_Time), median(Response_Time, na.rm = TRUE), Response_Time),
    Responding_Units = ifelse(is.na(Responding_Units), median(Responding_Units, na.rm = TRUE), Responding_Units),
    Responding_Personnel = ifelse(is.na(Responding_Personnel), median(Responding_Personnel, na.rm = TRUE), Responding_Personnel),
    
    # For categorical columns, replace NA with "Unknown" or a relevant placeholder
    Fire_Alarm_Operation = ifelse(is.na(Fire_Alarm_Operation), "Unknown", Fire_Alarm_Operation),
    Fire_Alarm_Presence = ifelse(is.na(Fire_Alarm_Presence), "Unknown", Fire_Alarm_Presence),
    Incident_Type = ifelse(is.na(Incident_Type), "Unknown", Incident_Type),
    Extent_of_Fire = ifelse(is.na(Extent_of_Fire), "Unknown", Extent_of_Fire),
    Area_of_Origin = ifelse(is.na(Area_of_Origin), "Unknown", Area_of_Origin),
    Incident_Ward = ifelse(is.na(Incident_Ward), "Unknown", Incident_Ward),
    Incident_Station_Area = ifelse(is.na(Incident_Station_Area), "Unknown", Incident_Station_Area)
  )


remove_outliers <- function(x) {
  Q1 <- quantile(x, 0.25, na.rm = TRUE)
  Q3 <- quantile(x, 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  x[x < lower_bound | x > upper_bound] <- NA
  return(x)
}

cleaned_data <- cleaned_data %>%
  mutate(
    Response_Time = remove_outliers(Response_Time),
    Estimated_Loss = remove_outliers(Estimated_Loss)
  )



glimpse(cleaned_data)

write.csv(cleaned_data, "../data/cleaned_data/fire_incidents_cleaned.csv", row.names = FALSE)





ggplot(cleaned_data, aes(x = Response_Time)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Response Time", x = "Response Time (minutes)", y = "Count") +
  theme_minimal()


ggplot(cleaned_data, aes(x = Estimated_Loss)) +
  geom_histogram(binwidth = 5000, fill = "lightgreen", color = "black") +
  labs(title = "Distribution of Estimated Loss", x = "Estimated Loss ($)", y = "Count") +
  theme_minimal()


ggplot(cleaned_data, aes(x = Incident_Type, y = Response_Time)) +
  geom_boxplot(fill = "lightblue", color = "black") +
  labs(title = "Response Time by Incident Type", x = "Incident Type", y = "Response Time (minutes)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


ggplot(cleaned_data, aes(x = Response_Time, y = Estimated_Loss)) +
  geom_point(alpha = 0.5, color = "darkblue") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Response Time vs Estimated Loss", x = "Response Time (minutes)", y = "Estimated Loss ($)") +
  theme_minimal()


ggplot(cleaned_data, aes(x = Incident_Station_Area)) +
  geom_bar(fill = "orange") +
  labs(title = "Number of Fire Incidents by Station Area", x = "Station Area", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


ggplot(cleaned_data, aes(x = Responding_Units, y = Estimated_Loss)) +
  geom_point(alpha = 0.5, color = "purple", position = position_jitter(width = 0.2, height = 500)) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Responding Units vs Estimated Loss", x = "Number of Responding Units", y = "Estimated Loss ($)") +
  theme_minimal() +
  xlim(0, 50)



ggplot(cleaned_data, aes(x = Fire_Alarm_Presence, y = Estimated_Loss)) +
  geom_boxplot(fill = "lightcoral", color = "black") +
  labs(title = "Effect of Fire Alarm Presence on Estimated Loss", x = "Fire Alarm Presence", y = "Estimated Loss ($)") +
  theme_minimal()








