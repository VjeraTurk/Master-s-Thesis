library("sp")
library("rgdal")
library("geosphere")

xy<-vor_pts    
mdist <- distm(xy)# use the distm function to generate a geodesic distance matrix in meters

# cluster all points using a hierarchical clustering approach
#hc <- hclust(as.dist(mdist), method="complete")
hc <- hclust(as.dist(mdist), method="complete")

# define the distance threshold, in this case 40 m
# all points in the group should be within 40m of each other.
  d = 0 #1090
  d = 75    # 973  
  d = 100   # 932
  d = 200   # 693
  d = 500   # 333
d = 1000  # 74
  d = 1500  # 40

# define clusters based on a tree "height" cutoff "d" and add them to the SpDataFrame
xy$clust <- cutree(hc, h=d)
max(xy$clust)

library(dismo)
library(rgeos)

# expand the extent of plotting frame
xy@bbox[] <- as.matrix(extend(extent(xy),0.001))


# get the centroid coords for each cluster
cent <- matrix(ncol=2, nrow=max(xy$clust))
for (i in 1:max(xy$clust))
  # gCentroid from the rgeos package
  cent[i,] <- gCentroid(subset(xy, clust == i))@coords

cent_df<-as.data.frame(cent)
names(cent_df)<-c("Longitude","Latitude")

  # compute circles around the centroid coords using a 40m radius
  # from the dismo package
  ci <- circles(cent, d=d, lonlat=T)
  
  # plot
  plot(ci@polygons, axes=T)
  plot(xy, col=rainbow(4)[factor(xy$clust)], add=T)



