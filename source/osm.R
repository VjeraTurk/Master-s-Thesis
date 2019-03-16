require("osmar")
require("OpenStreetMap")
require("rgdal")
setwd("~/CODM/masters-thesis/data/osm")
  "
  Relation: Shenzhen City (3464353)
  on map: 
            22.8040
  113.6604          114.6217
            22.4402
  
  pair format: Longitude_Latitude
  "

  system.time(map<-get_osm(complete_file(), source = osmsource_file("~/CODM/masters-thesis/data/osm/shenzhen.osm")))
  #user  system elapsed 
  #571.016   1.100 573.208 

  save(map, file = paste(getwd(),"/map.RData",sep=""))

file = paste(getwd(),"/map.RData",sep="")
load(file = file)
#plot(map,raster=TRUE)

plot(map, way_args = list(col = gray(0.7)), node_args = list(pch = 19, cex = 0.1, col = gray(0.3)))
plot_nodes(map, add = FALSE)
plot_ways(map, add = FALSE, xlab = "lon", ylab = "lat")


bckg <- openmap(c(22.8040,113.6604), c(22.4402,114.6217))
plot(bckg)
