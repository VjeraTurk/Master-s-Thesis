"Chi maps
After discretising the trajectory pattern S to some point patterns and being able to estimate
the individual intensity functions λi (·), one may think of discovering the areas with more/less
events than the expected number. This motivates us to think of χ2 statistics

...
<formula> is the expected intensity at time t = t1 and location u ∈ W . 2 
...

The resulting map discloses the areas where the estimated intensity differs from the expected intensity. 

...

The function chimaps generates a
map based on a given timestamp and rank. The argument rank is a number between one and
the length of the generated time sequence based on the given timestamp, and with default
one.

"
library("taxidata")
system.time(Beijing <- taxidata)
Beijing <- Beijing[1:2000]


system.time(ch <- chimaps(Beijing,timestamp = "20 mins",rank = 1))

chall <- attr(ch,"ims")

minmax <- lapply(X=1:length(chall),function(i){
      return(list(min(chall[[i]]$v),max(chall[[i]]$v)))
})

minmax <- do.call("rbind",minmax)
col5 <- colorRampPalette(c('blue','white','red'))
color_levels=200
par(mar=c(0,0,1,1))
par(mfrow=c(1,3))
plot(chall[[51]],zlim=c(-max(abs(unlist(minmax))),max(abs(unlist(minmax)))),main="",ribwid=0.04,ribsep=0.02,col=col5(n=color_levels),cex.axis=1.7)
title(attr(ch,"timevec")[51],line = -10,cex.main=2)
plot(chall[[75]],zlim=c(-max(abs(unlist(minmax))),max(abs(unlist(minmax)))),main="",ribwid=0.04,ribsep=0.02,col=col5(n=color_levels),cex.axis=1.7)

title(attr(ch,"timevec")[75],line = -10,cex.main=2)
plot(chall[[104]],zlim=c(-max(abs(unlist(minmax))),max(abs(unlist(minmax)))),main="",ribwid=0.04,ribsep=0.02,
col=col5(n=color_levels),cex.axis=1.7)
title(attr(ch,"timevec")[104],line = -10,cex.main=2)

" We show the chi maps for three different
times during the day in which changes over time can be seen. The left plot of Figure 11 shows
the chi map at 06:10:44 so that the estimated intensity is higher than the expected intensity
in the countryside. The reason for this might be the movements from countryside to the city
center in the early morning. The middle plot of Figure 11 shows that the estimated intensity
in the city is higher than the expected intensity. This may be caused by heavier traffic in
the city during the day than in the countryside. In the right plot of Figure 11, although
the estimated intensity is still slightly higher than the expected one in the city, we can see
that the χ2 statistic 8 takes values around 0 almost everywhere at night. These three plots
together confirm the changes in the values of the χ2 statistic 8 over time so that the mass
is moving to the city in the morning and goes away in the evening. This behaviour may be
explained by the movements to the city in the morning and moving back to the countryside
in the evening.
"

"The left plot displays the variation of K-function, showing that for small distances
taxis tend to have a clustering behaviour while for larger distances they favour inhibition. The
right plot of the variation of the pair correlation function also confirms the same behaviour.
Due to the preference of moving within particular zones, K-function and pair correlation
function might result as what is displayed in Figure 12. In other words, taxis might prefer to
take passengers to close destinations within particular zones rather than further destinations.
"

system.time(K <- Kinhom.Track(Beijing, timestamp = "20 mins", correction = "translate", q=0))#prilično dugo

par(mfrow=c(1,2),mar=rep(5,4))
plot(K,cex.axis=1.7,cex.lab=1.5,cex=2)
g <- pcfinhom.Track(Beijing,timestamp = "20 mins",q=0)
system.time(plot(g,cex.axis=1.7,cex.lab=1.5,cex=2))#traje jako dugo, mozda i dulje od pola sata# prekinuto
