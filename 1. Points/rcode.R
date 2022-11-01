library(tidyverse)
library(sf)

# pub data
data <- read.csv('1. Points/data/open_pubs_london.csv', header = F,
                 col.names = c('fsa_id', 'name', 'address', 'postcode',
                               'easting', 'northing', 'latitude', 'longitude',
                               'local_authority'))
data <- data %>% drop_na()

# london borough shapefile
london_shp <- st_read("1. Points/data/London_Borough_Excluding_MHW.shp") 

ggplot() + 
  geom_sf(data = london_shp, fill='white') +
  geom_point(aes(x=data$easting,y=data$northing),col="#e5a11f",
             alpha=0.6, size=.75) +
  labs(title = "Pubs of London",
       caption = "Data derived from the Food Standard Agency's Food Hygiene Ratings and the ONS Postcode Directory. \nContains National Statistics and Ordnance Survey data © Crown copyright and database right [2015] \n
GitHub: lyrab96") +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, vjust = -1, size = 18),
        plot.caption = element_text(hjust = 0))

dev.off()
