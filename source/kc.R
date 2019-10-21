"Koprivnica osm and BS"
require("data.table")
setwd("/home/adminuser/CODM/masters-thesis/data/cell")
file="219.csv"
base_stations<-fread(file=file, sep="auto", header=TRUE, quote="")
"
        46.2026
16.7246         16.9392
        46.1232
"
kc_bs<-base_stations[lat < 46.2026 & lat > 46.1232 & lon < 16.9392 & lon > 16.7246 & radio=="LTE"] #276 obs. #74 GSM #47 LTE
LonLat<-data.frame(kc_bs$lon,kc_bs$lat)
colnames(LonLat)<-c("Longitude","Latitude")
#LonLat<-LonLat[1:262,]
SPointsDF_to_voronoi_SPolysDF <- function(sp) {
  
  # tile.list extracts the polygon data from the deldir computation
  vor_desc <- tile.list(deldir(sp@coords[,1], sp@coords[,2])) #only 262/276?!
  
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
  rownames(sp_dat) <- sapply(slot(SpatialPolygons(vor_polygons),'polygons'),slot, 'ID')
  
  SpatialPolygonsDataFrame(SpatialPolygons(vor_polygons), data=sp_dat)
  
}

vor_pts <- SpatialPointsDataFrame(cbind(LonLat$Longitude, LonLat$Latitude), LonLat, match.ID=TRUE)
vor <- SPointsDF_to_voronoi_SPolysDF(vor_pts)
sp<-vor_pts
system.time(vor_df <- fortify(vor))


library(OpenStreetMap)
LAT1 = 46.1232
LON1 = 16.7246

LAT2 = 46.2026
LON2 = 16.9392

"
        46.2026
16.7246         16.9392
        46.1232
"
map <- openmap(c(LAT2,LON1), c(LAT1,LON2), zoom = NULL,
               type = c("osm", "stamen-toner", "stamen-terrain","stamen-watercolor", "esri","esri-topo")[1],
               mergeTiles = TRUE)
map.latlon <- openproj(map, projection = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
gg <- ggplot()
gg <- autoplot(map.latlon) + geom_point(data=LonLat, aes(x=Longitude, y=Latitude),size=1, shape=21, color="white", fill="steelblue")+ geom_map(data=vor_df, map=vor_df, aes(x=long, y=lat, map_id=id), color="#a5a5a5", fill="#FFFFFF00", size=0.25)

m<-matrix(sample.int(15, 33*33, TRUE), 33, 33)
diag(m) <- 0
heatmap(m,Rowv = NA,Colv = NA)
