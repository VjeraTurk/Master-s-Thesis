#pkgs <- c("sp","rgdal","deldir","dplyr","ggplot2","ggthemes", "rgdal")
#install.packages(pkgs)
require(sp)
require(rgdal)
require(deldir)
require(dplyr)
require(ggplot2)
require(ggthemes)

SPointsDF_to_voronoi_SPolysDF <- function(sp) {
  
  # tile.list extracts the polygon data from the deldir computation
  vor_desc <- tile.list(deldir(sp@coords[,1], sp@coords[,2]))
  
  lapply(1:(length(vor_desc)), function(i) {
    
    # tile.list gets us the points for the polygons but we
    # still have to close them, hence the need for the rbind
    tmp <- cbind(vor_desc[[i]]$x, vor_desc[[i]]$y)
    tmp <- rbind(tmp, tmp[1,])
    
    # now we can make the Polygon(s)
    Polygons(list(Polygon(tmp)), ID=i)
    
  }) -> vor_polygons
  
  # hopefully the caller passed in good metadata!
  sp_dat <- sp@data
  
  # this way the IDs _should_ match up w/the data & voronoi polys
  rownames(sp_dat) <- sapply(slot(SpatialPolygons(vor_polygons),
                                  'polygons'),
                             slot, 'ID')
  
  SpatialPolygonsDataFrame(SpatialPolygons(vor_polygons),
                           data=sp_dat)
  
}

setwd("~/CODM/masters-thesis/data")
file = paste(getwd(),"/LonLat_from_CDR_1090_pairs.RData", sep="")
system.time(load(file = file))
LonLat<-as.data.frame(LonLat)

vor_pts <- SpatialPointsDataFrame(cbind(LonLat$Longitude, LonLat$Latitude), LonLat, match.ID=TRUE)

vor <- SPointsDF_to_voronoi_SPolysDF(vor_pts)
system.time(vor_df <- fortify(vor))

  save(vor_df, file = paste(getwd(),"/vor_df.RData", sep=""))
  save(vor, file = paste(getwd(),"/vor.RData", sep=""))


#gg <- ggplot()
# base map
#gg <- gg + geom_map(data=states, map=states, aes(x=long, y=lat, map_id=region), color="white", fill="#cccccc", size=0.5)
#gg <- gg + geom_point(data=arrange(airports, desc(tot)),aes(x=Longitude, y=Latitude, size=sqrt(tot)), shape=21, color="white", fill="steelblue")
#gg <- gg + geom_point(data=arrange(LonLat, desc(tot)),aes(x=Longitude, y=Latitude, size=sqrt(tot)), shape=21, color="white", fill="steelblue")
#gg <- gg + scale_size(range=c(2, 9))
#gg <- gg + coord_map("albers", lat0=30, lat1=40)
#gg <- gg + theme_map()
#gg <- gg + theme(legend.position="none")

gg <- ggplot()
# base map
#gg <- gg + geom_map(data=states, map=states, aes(x=long, y=lat, map_id=region), color="white", fill="#cccccc", size=0.5)
gg <- gg + geom_point(data=LonLat, aes(x=Longitude, y=Latitude),size=1, shape=21, color="white", fill="steelblue")
# voronoi layer
gg <- gg + geom_map(data=vor_df, map=vor_df, aes(x=long, y=lat, map_id=id), color="#a5a5a5", fill="#FFFFFF00", size=0.25)
#gg <- gg + geom_point(data=LonLat, aes(x=Longitude, y=Latitude),size=1, shape=21, color="white", fill="red")
#taxi_points <- data.frame(taxiSP)
#gg<- gg + geom_point(data=taxi_points, aes(x=coords.x1, y=coords.x2), size=1, shape=21, color="black", fill="yellow")

#gg <- autoplot(map.latlon) + geom_point(data=LonLat, aes(x=Longitude, y=Latitude),size=1, shape=21, color="white", fill="steelblue")+ geom_map(data=vor_df, map=vor_df, aes(x=long, y=lat, map_id=id), color="#a5a5a5", fill="#FFFFFF00", size=0.25)
gg

