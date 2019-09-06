install.packages("trackeR")
install.packages("taxidata", repos = "http://pebesma.staff.ifgi.de",type = "source")
install.packages("spatstat")
install.packages("spacetime")
install.packages("trajectories")

library("trajectories")

"The class ‘Track’ represents a single track followed by a person, animal or an object. In-
stances of this class are meant to hold a series of consecutive location/timestamps that are
not interrupted by another activity. The class contains five slots: @sp to store the spatial
points, @time to store the corresponding time, @endtime to store the end time when having
generalised line geometries with one value per attribute for a set of points (otherwise, de-
faults to the time defined in @time), @data to store the attributes (covariate information)
and @connections to keep a record of attribute data between points (e.g., distance, duration,
speed and direction). A ‘Track’ object can be created out of an ‘STIDF’ (see Pebesma (2012))
object as follows
"
set.seed(10)
library("spacetime")
library("sp")
t0 = as.POSIXct(as.Date("2013-09-30",tz="CET"))
x = c(7,6,5,5,4,3,3)
y = c(7,7,6,5,5,6,7)

n = length(x)
t = t0 + cumsum(runif(n) * 60)
crs = CRS("+proj=longlat +ellps=WGS84") # longlat
stidf = STIDF(SpatialPoints(cbind(x,y),crs), t,
+data.frame(co2 = rnorm(n,mean = 10)))

A1 = Track(stidf)
A1



x <- runif(10,0,1)
y <- runif(10,0,1)
date <- seq(as.POSIXct("2015-1-1 0:00"), as.POSIXct("2015-1-1 9:00"),by = "hour")
records <- as.data.frame(rpois(10,5))
as.Track(x,y,date,covariate = records)


"The class ‘Tracks’ embodies a collection of tracks followed by a single person, animal or
object. The class contains two slots: @tracks to store the tracks as objects of class ‘Track’
and @tracksData to hold a summary record for each particular track (e.g., minimum and
maximum time, total distance and average speed). "

plot(A1)

x = c(7,6,6,7,7)
y = c(6,5,4,4,3)
n = length(x)
t = max(t) + cumsum(runif(n) * 60)
stidf = STIDF(SpatialPoints(cbind(x,y),crs), t,data.frame(co2 = rnorm(n,mean = 10)))
A2 = Track(stidf)
# Tracks for person A:
A = Tracks(list(A1=A1,A2=A2))
A

"The class ‘TracksCollection’ represents a collection of tracks followed by many persons,
animals or objects. The class contains two slots: @tracksCollection to store the tracks as
objects of class ‘Tracks’ and @tracksCollectionData to hold summary information about
each particular person, animal or object (e.g., the total number of tracks per each object). A
‘TracksCollection’ object can be created by:
"
  # person B, track 1:

x = c(2,2,1,1,2,3)
y = c(5,4,3,2,2,3)
n = length(x)
t = max(t) + cumsum(runif(n) * 60)
stidf = STIDF(SpatialPoints(cbind(x,y),crs), t,data.frame(co2 = rnorm(n,mean = 10)))
B1 = Track(stidf)
# person B, track 2:
x = c(3,3,4,3,3,4)
y = c(5,4,3,2,1,1)
n = length(x)
t = max(t) + cumsum(runif(n) * 60)
stidf = STIDF(SpatialPoints(cbind(x,y),crs), t,data.frame(co2 = rnorm(n,mean = 10)))
B2 = Track(stidf)
# Tracks for person B:
B = Tracks(list(B1=B1,B2=B2))
Tr = TracksCollection(list(A=A,B=B))
Tr
plot(Tr)

"
methods
"
dim(A1)
dim(B1)
stbox(A1)
downsample(A1,B1)


"Simulating trajectory patterns can be a useful tool to imitate true models and understand
their behaviour. The package trajectories allows simulating tracks using rTrack, rTracks,
rTracksCollection where rTrack() generates a single track, rTracks() simulates a collec-
tion of tracks assumed to be passed by a single object and rTracksCollection is used to
simulate a set of tracks passed by different objects. By default, these functions do not con-
sider any box (or window) for the track to be simulated in and consider origin=c(0,0) as the
origin of the track. However, one can still restrict the track to a desirable closed box using the
argument bbox. If transform=TRUE and no bbox is given, then rTrack transforms the track
to the default box [0, 1] × [0, 1], where in this case the origin is a random point in the default
box. If a default box bbox (e.g., m in the following example) is given and transform=TRUE,
then origin is a random point in bbox and the final track is also transformed into bbox. The
function rTrack simulates tracks with a predefined number of points per track (indicated as
n in the code with default 100). However if nrandom=TRUE then it simulates a track with a
random number of points based on a Poisson distribution with parameter n. An example of
these functions is the following:

"
stplot(Tr, attr = "co2", arrows = TRUE, lwd = 3, by = "IDs",cex.axis=2)
set.seed(10)
x <- rTrack();x
y <- rTrack(transform = T);y
m <- matrix(c(0,10,0,10),nrow=2,byrow = T)
w <- rTrack(bbox = m,transform = T);w

z <- rTrack(bbox = m,transform = T,nrandom = T)
z
