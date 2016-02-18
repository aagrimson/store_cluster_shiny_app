

kmeans(faithful, centers = 3)

library(ggplot2)
library(tidyr)
library(dplyr)

data <- read.csv("~/GitHub/sptn projects/shiny_app/store_cluster_data.csv")
data <- spread(data, SEGMENT_VALUE, SEGMENT_CODE_PROP, fill = 0)

location_dim <- read.csv("~/GitHub/sptn projects/shiny_app/location_dim.csv")

cl <- kmeans(select(data_spread, -LOCATION_ID), centers = 5)


###################################################


data <- read.csv("~/GitHub/sptn projects/shiny_app/store_cluster_data.csv")

data <- spread(select(data, -TXN_CNT), SEGMENT_CODE, SEGMENT_CODE_PROP, fill = 0)


cl <- kmeans(select(data_spread, -LOCATION_ID), centers = 5)

cbind(cl$size, cl$centers)


cl_assign <- data.frame(LOCATION_ID=data_spread$LOCATION_ID, CLUSTER = cl$cluster)

inner_join(location_dim, cl_assign)