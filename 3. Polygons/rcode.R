library(tidyverse)
library(maptools)
library(sf)
library(sp)

data(wrld_simpl)
data <- read.csv('3. Polygons/data.csv', col.names = c('Country','Trade_Balance_GDP_perc'),
                 sep=';')

afr = wrld_simpl[wrld_simpl$REGION==2,]

afr <- sp::merge(afr, data, by.x='NAME', by.y='Country')

AFR <- st_as_sf(afr)

ggplot(AFR, 
       aes(fill = Trade_Balance_GDP_perc)) + 
  geom_sf(colour = 'black',lwd=0.1) +
  scale_fill_gradient2(low='red',high='green',midpoint=0,
                       breaks = c(-50,-25,0,25),
                       labels = c("-50%","-25%", "0%", "25%")) +
  geom_text(data = AFR %>% filter(NAME %in% c('Seychelles','Mauritius',
                                              'Cape Verde','Comoros','Sao Tome and Principe')),
                                  aes(LON, LAT - 2.5, label = Trade_Balance_GDP_perc), size = 3) +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        legend.position = 'bottom',
        legend.title = element_blank(),
        legend.key.width= unit(1, 'cm'),
        legend.key.height= unit(0.1, 'cm'),
        legend.margin=margin(0,0,0,0),
        legend.box.margin=margin(-50,-10,10,-10),
        plot.caption = element_text(hjust = 0),
        plot.subtitle = element_text(size = 10)
        ) +
  labs(title = 'Trade Balance as Percentage of GDP in Africa',
       subtitle = 'Difference between the exports and imports of goods and services, as percent of GDP',
       caption = 'Data Source: The World Bank \nGitHub: lyrab96')

dev.off()