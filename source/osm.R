setwd("~/CODM/masters-thesis/data/osm")
require("osmar")
system.time(get_osm(complete_file(), source = osmsource_file("~/CODM/masters-thesis/data/osm/shenzhen.osm")))
