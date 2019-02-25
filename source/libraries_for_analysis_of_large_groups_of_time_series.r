"
Analysis of large groups of time series
Time series clustering is implemented in TSclust, dtwclust, BNPTSclust and pdc.

TSdist provides distance measures for time series data.

TSrepr includes methods for representing time series using dimension reduction and feature extraction.

jmotif implements tools based on time series symbolic discretization for finding motifs in time series 
and facilitates interpretable time series classification.

rucrdtw provides R bindings for functions from the UCR Suite to enable ultrafast subsequence search for 
a best match under Dynamic Time Warping and Euclidean Distance.

Methods for plotting and forecasting collections of hierarchical and grouped time series are provided by
hts. thief uses hierarchical methods to reconcile forecasts of temporally aggregated time series. 
An alternative approach to reconciling forecasts of hierarchical time series is provided by gtop. thief
"

require(timeSeries)#rovides a class and various tools for financial time series. This includes basic functions such as scaling and sorting, subsetting, mathematical operations and statistical functions.
require(jmotif)#jmotif implements tools based on time series symbolic discretization for finding motifs in time series and facilitates interpretable time series classification.
require(xts)

#split(PDsample, cut(PDsample$Time,breaks = "hour"))
##PDsample$group = cumsum(ifelse(difftime(PDsample$Time, shift( PDsample$Time, fill = PDsample$Time[1]),units = "hours") >=3))

require(h2o)
