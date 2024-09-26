#### Preamble ####
# Purpose: Simulates the data from opendatatoronto
# Author: Qisheng Yu
# Date: 20 Sep 2024
# Contact: qisheng.yu@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
# [...UPDATE THIS...]

set.seed(123)

n <- 100  
fire_incidents_sim <- data.frame(
  IncidentID = 1:n,
  Date = as.Date('2024-01-01') + sample(0:365, n, replace = TRUE),
  IncidentType = sample(c("Fire", "Medical", "Rescue", "Other"), n, replace = TRUE),
  Location = paste("Location", sample(1:10, n, replace = TRUE)),
  ResponseTimeMinutes = round(runif(n, min = 5, max = 45), 2),
  NumberOfUnits = sample(1:10, n, replace = TRUE)
)

glimpse(fire_incidents_sim)


