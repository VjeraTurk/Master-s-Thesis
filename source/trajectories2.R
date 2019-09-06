"Model fitting
The behaviour of a track might also be studied using available tools for time series modelling.
However, obtaining a proper model is extremely important as it highlights the underlying
structure of the series, and the fitted model can be used for future forecasting. The R package
trajectories can fit ARIMA models to movement data. Using R package forecast, the function
auto.arima.Track fits arima models to the spatial coordinates of an object of class ‘Track’.
Note this is applicable to individuals. See example below.
"
install.packages("forecast")
library("forecast")
data("A3")
auto.arima.Track(A3)

par(mfrow=c(2,2),mar=rep(2.2,4))
plot(x,lwd=2,main="x");plot(y,lwd=2,main="y")
plot(w,lwd=2,main="w");plot(z,lwd=2,main="z")
