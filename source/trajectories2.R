"Model fitting
The behaviour of a track might also be studied using available tools for time series modelling.
However, obtaining a proper model is extremely important as it highlights the underlying
structure of the series, and the fitted model can be used for future forecasting. The R package
trajectories can fit ARIMA models to movement data. Using R package forecast, the function
auto.arima.Track fits arima models to the spatial coordinates of an object of class ‘Track’.
Note this is applicable to individuals. See example below.
"

"install.packages('forecast')"

library("forecast")
data("A3")
auto.arima.Track(A3)

par(mfrow=c(2,2),mar=rep(2.2,4))
plot(x,lwd=2,main="x");plot(y,lwd=2,main="y")
plot(w,lwd=2,main="w");plot(z,lwd=2,main="z")

"Distance analysis
A simple way to get into the nature of movement data is to study the distance between
objects. The function dists provides users with calculating the distance between a pair of
objects of class ‘Tracks’. This considers the distance between tracks when they overlap in
time. The output is a matrix with distances between each pair of tracks or ’NA’, if they do
not overlap in time. A function to calculate distances can be passed to dists, such as mean,
sum, frechetDist, etc.
"
## create Tracks objects
tracks1 <- Tracks(list(Beijing[[1]], Beijing[[2]]))
tracks2 <- Tracks(list(Beijing[[2]], Beijing[[1]]))
dists(tracks1, tracks2,mean)
#Found more than one class "xts" in cache; using the first, from namespace 'spacetime'
#Also defined by ‘quantmod’

"Distance analysis

1. Based on the time range of all tracks si, create a regular time sequence.
2. Interpolate each track si based on the created time sequence. For this purpose, the
function reTrack can be used. It reconstructs each track si according to a desirable
time sequence.
3. Discretise the trajectory pattern S to a collection of point patterns x1, x2 , . . . , xk .
Note that the number of points in each pattern might be different.
4. For each xi , i = 1, . . . , k, calculate pairwise distances between all data points.
5. Report the average of pairwise distances per each time.
"

par(mfrow=c(1,2))
#gdje je tko bio u trenutku svakih 20 minuta, interpolira i diskretizira putanje, određuje udaljenosti objekata pairwise i vraća prosjek udaljenosti za svaki trenutak:
system.time(meandist <- avedistTrack(Beijing,timestamp = "20 mins") ) #Warning: traje jako dugo
#user  system elapsed 
#440.296   0.916 441.775 

plot(meandist,type="l",lwd=2,cex.axis=1.7,cex.lab=1.7)
distinframe <- data.frame(tsq=attr(meandist,"tsq"),dist=meandist)
dist3rd <- distinframe[substr(distinframe$tsq,start = 1,stop=10)=="2008-02-03",]
plot(dist3rd$tsq,dist3rd$dist,type="l",xlab="time", ylab="average distance",lwd=2,cex.axis=1.7,cex.lab=1.7)

system.time(b <- Track.idw(Beijing,timestamp = "20 mins",epsilon=1000)) #epsilon u metrima, duljinu kraću od 1000 metara u 20 minuta gleda kao stajanje

plot(b,main="",ribwid=0.04,ribsep=0.02,cex.axis=1.5)
  
"The function avemove measures the average
length of movements passed by a collection of tracks based on a desirable timestamps."
system.time(q <- avemove(Beijing,timestamp = "20 mins",epsilon=1000))# WARNING: traje dugo

par(mfrow=c(1,2))
plot(q,type="l",lwd=2,cex.axis=1.7,cex.lab=1.7)
qdata <- data.frame(q,attr(q,"time"))
colnames(qdata) <- c("dist","startingtime")
q3rd <- qdata[substr(qdata$startingtime,start = 1,stop=10)=="2008-02-03",]
plot(q3rd$startingtime,q3rd$dist,type="l",xlab="time (hour)",ylab="average movement",lwd=2,cex.axis=1.7,cex.lab=1.7)

"Figure shows the average length of movements per 20 minutes by taxis in Beijing. The daily
trend can be seen in the left plot, and the right plot shows that between midnight and early
morning, the average length of movements is decreasing while from morning till noon there
is an increase in the length of movements. In the afternoon, there can be seen a decrease in
the average length of movements which might be caused by traffic.
"
library("spatstat")
system.time(d <- density(Beijing,timestamp = "20 mins",bw.ppl))#WARNING!!! jako dugo se izvršava
par(mfrow=c(1,2),mar=rep(1,4))
plot(d,main="",ribwid=0.04,ribsep=0.02,cex.axis=1.7)
#focus on the center
w <- owin(c(440000,455000),c(4410000,4430000))
pps <- attr(d,"ppps")

npps <- lapply(X=1:length(pps),FUN = function(i){
  pps[[i]][w]
})
centerimg <- lapply(X=1:length(npps),FUN = function(i){
  density(npps[[i]],bw.ppl(npps[[i]]))
})

fcenterimg <- Reduce("+",centerimg)/length(centerimg)
plot(fcenterimg,main="",ribwid=0.04,ribsep=0.02,cex.axis=1.7)

"Figure shows the estimated intensity using the estimator 4 for both Beijing and its
metropolitan area. The bandwidth has been selected using a likelihood cross-validation
method and the function bw.ppl in spatstat. Other bandwidth selection methods can also
be passed to density.list. Figure 10 highlights the most well-traveled areas in which those
areas in the countryside with higher intensities (left plot) are some townships or airports.
The right plot highlights the crowded routes within the centre of Beijing, China.
"
    