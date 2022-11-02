library(tidyverse)
library("CycleInfraLnd") # devtools::install_github("PublicHealthDataGeek/CycleInfraLnd")
library(tmap)
library(spData)

cid_cycle_lanes = get_cid_lines(type = "cycle_lane_track")

#london boroughs data
london_boroughs = spData::lnd

#filter for city of london
city_of_london = london_boroughs %>% 
  filter(NAME == "City of London")

cid_cycle_lanes_col= cid_cycle_lanes[city_of_london, , op = sf::st_within] 

tmap_mode(mode = "view") #tmap mode set to interactive viewing

tm_shape(cid_cycle_lanes_col, name = 'Cycle Lanes: City of London', unit='mi')+
  tm_lines(lwd = 2,col = 'darkblue') 

dev.off()
