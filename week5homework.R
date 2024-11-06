
#-------read data
library(sf)
library(dplyr)
library(readr)
library(tidyverse)
library(tmap)
library(janitor)

worldmap <- st_read("/Users/haohaohaojiu/Downloads/CASA005/week4-0005/数据/World_Countries_(Generalized)_9029012925078512962.geojson")
gender_csv <- read.csv("/Users/haohaohaojiu/Downloads/CASA005/week4-0005/数据/HDR23-24_Composite_indices_complete_time_series.csv", 
                       header = TRUE, sep = ",", encoding = "latin1",
                       na = "NULL")

colnames(gender_csv)

#------choose data 
choose_gender_csv <- gender_csv %>%
  clean_names(.) %>%
  select(country,gii_2010,gii_2019) %>%
  group_by(country) %>%
  na.omit() %>%
  mutate(difference_in_inequality=gii_2019-gii_2010) 

#-------merging spatial data and csv
spatial_data <- worldmap %>%
  merge(.,
        choose_gender_csv,
        by.x="COUNTRY",
        by.y="country")

spatial_data%>%
  head(., n=10)


#-------visualizing data
tmap_mode("plot")
spatial_data %>%
  qtm(.,fill="difference_in_inequality")

#just a test




