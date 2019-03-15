setwd("~/CODM/masters-thesis/data/osm")
require("osmar")
system.time(map<-get_osm(complete_file(), source = osmsource_file("~/CODM/masters-thesis/data/osm/shenzhen.osm")))
#user  system elapsed 
#571.016   1.100 573.208 

save(map, file = paste(getwd(),"/map.RData",sep=""))
