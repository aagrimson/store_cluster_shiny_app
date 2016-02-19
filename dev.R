

library(tidyr)
library(dplyr)
library(stringr)
library(fpc)

#data <- read.csv("~/GitHub/sptn projects/shiny_app/store_cluster_data.csv")
#data <- spread(data, SEGMENT_VALUE, SEGMENT_CODE_PROP, fill = 0)


clustering_data <- read.csv("~/GitHub/sptn projects/shiny_app/clustering_data.csv")

names(clustering_data) <- str_to_lower(names(clustering_data))

location_dim <- read.csv("~/GitHub/sptn projects/shiny_app/location_dim.csv")


segmentation <- 'customer_style'
segmentation <- 'engagement'
segmentation <- 'both'


if (segmentation == 'customer_style'){
  data <- clustering_data %>%
            group_by(location_id, customer_style) %>%
            summarise(segment_dist = sum(segment_dist)) %>%
            spread(customer_style, segment_dist, fill = 0)
  
} else if (segmentation == 'engagement'){
  data <- clustering_data %>%
            group_by(location_id, engagement) %>%
            summarise(segment_dist = sum(segment_dist)) %>%
            spread(engagement, segment_dist, fill = 0)
  
} else if (segmentation == 'both'){
  data <- clustering_data %>%
            group_by(location_id, style_engagement) %>%
            summarise(segment_dist = sum(segment_dist)) %>%
            spread(style_engagement, segment_dist, fill = 0)
  
}
  





###################################################


cl <- kmeans(select(data, -LOCATION_ID), centers = 17)


d <- dist(data[, 2:9])

cluster.stats(d, cl$cluster)$avg.silwidth

###################################################


data <- read.csv("~/GitHub/sptn projects/shiny_app/store_cluster_data.csv")

data <- spread(select(data, -TXN_CNT), SEGMENT_CODE, SEGMENT_CODE_PROP, fill = 0)


cl <- kmeans(select(data_spread, -LOCATION_ID), centers = 5)

cbind(cl$size, cl$centers)


cl_assign <- data.frame(LOCATION_ID=data_spread$LOCATION_ID, CLUSTER = cl$cluster)

inner_join(location_dim, cl_assign)