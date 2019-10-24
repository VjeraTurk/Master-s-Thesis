"Koprivnica osm and BS"
require(sp)
require(rgdal)
require(deldir)
require(dplyr)
require(ggplot2)
require(ggthemes)

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

vor_pts <- SpatialPointsDataFrame(cbind(LonLat$Longitude, LonLat$Latitude), LonLat, match.ID=TRUE)
vor <- SPointsDF_to_voronoi_SPolysDF(vor_pts)
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

#### Agregacija ćelija
require("Matrix.utils")
#agg<-aggregate.Matrix(m, fun="sum") # moguce ok pristup

#loš pristup - sumiranje blokova elemenata - samo za probu
#https://stackoverflow.com/questions/16884384/blockwise-sum-of-matrix-elements

x<-matrix(sample.int(15, 33*33, TRUE), 33, 33) # random matrica
diag(x) <- 0
heatmap(x,Rowv = NA,Colv = NA)

y<-matrix(sample.int(15, 33*33, TRUE), 33, 33) # random matrica
diag(y) <- 0
heatmap(y,Rowv = NA,Colv = NA)

mat <- function(n, r) {
  suppressWarnings(matrix(c(rep(1, r), rep(0, n)), n, n/r))
}

###Shenzhen

x<-cdr
length(x[x==0]) # 1093177

y<-ztaxi # treba taxi izvrtiti do kraja, nije dovoljno 1m ?!
length(y[y==0]) # 1182918

b <- mat(1090,10)
b
x_10<-t(b) %*% x %*% b
heatmap(x_10,Rowv = NA,Colv = NA)

y_10<-t(b) %*% y %*% b
heatmap(y_10,Rowv = NA,Colv = NA)

SSIM(x,y,5)#[1] 0.9984854

y <- as.numeric(y)
x <- as.numeric(x)

plot(y~x)
mod1<-lm(y~x)
summary(mod1)
abline(mod1, lwd=2, col="red")

SSIM(y,x,5) # 0.998
SSIM(y_10,x_10,5) #[1] 0.861207

"Call:
lm(formula = y ~ x)

Residuals:
    Min      1Q  Median      3Q     Max 
-603.91    0.01    0.01    0.01 1150.24 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -5.452e-03  1.305e-03  -4.178 2.94e-05 ***
x            4.310e-02  5.889e-05 731.854  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.422 on 1188098 degrees of freedom
Multiple R-squared:  0.3107,	Adjusted R-squared:  0.3107 
F-statistic: 5.356e+05 on 1 and 1188098 DF,  p-value: < 2.2e-16
"

length(x_10[x_10==0]) # 2860
length(y_10[y_10==0]) # 9091

y_10 <- as.numeric(y_10)
x_10 <- as.numeric(x_10)
plot(y_10~x_10)
mod2<-lm(y_10~x_10)
summary(mod2)
abline(mod2, lwd=2, col="red")

"Call:
lm(formula = y_10 ~ x_10)

Residuals:
    Min      1Q  Median      3Q     Max 
-544.59   -0.21    0.24    0.35 1114.72 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -0.3531404  0.1299988  -2.716  0.00661 ** 
x_10         0.0377617  0.0004549  83.015  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 14.06 on 11879 degrees of freedom
Multiple R-squared:  0.3671,	Adjusted R-squared:  0.3671 
F-statistic:  6892 on 1 and 11879 DF,  p-value: < 2.2e-16"



## complete linckage?! #max
## single linkage #min
## average linkage

kmeans(kmeans())