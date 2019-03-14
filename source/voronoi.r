#pkgs <- c("sp","rgdal","deldir","dplyr","ggplot2","ggthemes", "rgdal")
#install.packages(pkgs)

require(sp)
require(rgdal)
require(deldir)
require(dplyr)
require(ggplot2)
require(ggthemes)

### All packages loaded

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

vor_pts <- SpatialPointsDataFrame(cbind(LatLon$longitude, LatLon$latitude), LatLon, match.ID=TRUE)
vor <- SPointsDF_to_voronoi_SPolysDF(vor_pts)
vor_df <- fortify(vor)

#gg <- ggplot()
# base map
#gg <- gg + geom_map(data=states, map=states, aes(x=long, y=lat, map_id=region), color="white", fill="#cccccc", size=0.5)
#gg <- gg + geom_point(data=arrange(airports, desc(tot)),aes(x=longitude, y=latitude, size=sqrt(tot)), shape=21, color="white", fill="steelblue")
#gg <- gg + geom_point(data=arrange(LatLon, desc(tot)),aes(x=longitude, y=latitude, size=sqrt(tot)), shape=21, color="white", fill="steelblue")
#gg <- gg + scale_size(range=c(2, 9))
#gg <- gg + coord_map("albers", lat0=30, lat1=40)
#gg <- gg + theme_map()
#gg <- gg + theme(legend.position="none")



gg <- ggplot()
# base map
gg <- gg + geom_map(data=states, map=states, aes(x=long, y=lat, map_id=region), color="white", fill="#cccccc", size=0.5)
gg <- gg + geom_point(data=LatLon, aes(x=Longitude, y=Latitude, size=3), shape=21, color="white", fill="steelblue")
# voronoi layer
gg <- gg + geom_map(data=vor_df, map=vor_df, aes(x=long, y=lat, map_id=id), color="#a5a5a5", fill="#FFFFFF00", size=0.25)
gg
