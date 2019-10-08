#install.packages("travelr", repos="http://R-Forge.R-project.org")
#install.packages('devtools')
#devtools::install_github('ropensci/gtfsr')
#install.packages("osmdata")
require(travelr)
## Not run: 
# A tiny, complete travel model using travelr functions
# You may run this example with example(skim.paths)
data(SiouxFalls)

# Trip Generation
productions<-rowSums(SiouxFalls.od)
attractions<-colSums(SiouxFalls.od)
heatmap(SiouxFalls.od, Colv = NA, Rowv = NA)

# Highway Skims
cost.function<-with(SiouxFalls.net$Links,function(...)FFTime)
aclass <- make.assignment.class(SiouxFalls.net,"All",SiouxFalls.od)
aset <- new.assignment.set(SiouxFalls.net,list(All=aclass),cost.volume.type="vector",cost.function=cost.function)
paths <- build.paths(aset,aset$ff.cost)
travel.times <- skim.paths(paths,aset$ff.cost)[["All"]] # only one purpose: "All trips"

# Trip Distribution (Gravity Model with gamma function)
base.distribution <- hwy.gamma.function(travel.times,-0.02,-0.123) # HBW coefficients from NCHRP 365
trip.table <- ipf(base.distribution,list(rows=productions, cols=attractions),method="absolute")
aset <- hwy.update.demand(aset,"All",trip.table)

# Trip Assignment
assignment.results <- highway.assign(aset,method="Frank.Wolfe")
loaded.links <- assignment.results$volumes

heatmap(trip.table, Colv = NA, Rowv = NA)
