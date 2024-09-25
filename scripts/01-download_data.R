#### Preamble ####
# Purpose: Downloads and saves the data from opendatatoronto
# Author: Qisheng Yu
# Date: 20 Sep 2024
# Contact: qisheng.yu@mail.utoronto.ca
# License: MIT



#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

package <- show_package("fire-incidents")

resources <- list_package_resources(package)

print(resources)

csv_resource <- resources %>%
  filter(grepl("csv", format, ignore.case = TRUE))

fire_incidents_data <- get_resource(csv_resource$id[1])  
fire_incidents_data

write.csv(fire_incidents_data, "../data/raw_data/raw_data.csv", row.names = FALSE)


         
