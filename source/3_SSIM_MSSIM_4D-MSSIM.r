#https://www.rdocumentation.org/packages/SPUTNIK/versions/1.1.1/topics/SSIM
#installed rpart,spatstat and SPUTNIK
require(SPUTNIK)

SSIM(ODout_SH_3_6,ODout_SH_6_9, 256) #incompatible dimensions

A<-ODout_SH_3_6
B<-ODout_SH_6_9

cAB <- intersect(colnames(A), colnames(B)) #442
rAB <- intersect(rownames(A), rownames(B)) #432

AA<-A[rAB,cAB]
BB<-B[rAB,cAB]

#SSIM is an image quality measure, given a reference considered as noise-less image.
#It can be also used as a perceived similarity measure between images. 
#The images are converted by default in 8bit.

ssim <- function(x, y, numBreaks = 256)
{
  x <- c(x) #vektor?
  y <- c(y)
  
  #normalizacija
  x <- x / max(x) 
  y <- y / max(y)
  
  #cut divides the range of x into intervals and codes the values in x 
  #according to which interval they fall. The leftmost interval corresponds to level one, 
  #the next leftmost to level two and so on.
  
  #breaks - either a numeric vector of two or more unique cut points or a single number 
  #(greater than or equal to 2) giving the number of intervals into which x is to be cut.
  
  x.dig <- cut(as.numeric(x), numBreaks, labels = F) - 1
  y.dig <- cut(as.numeric(y), numBreaks, labels = F) - 1
  rm(x, y)
  
  
  C1 <- (0.01 * (numBreaks - 1)) ^ 2
  C2 <- (0.03 * (numBreaks - 1)) ^ 2
  
  mux <- mean(x.dig)
  muy <- mean(y.dig)
  sigxy <- cov(x.dig, y.dig)
  sigx <- var(x.dig)
  sigy <- var(y.dig)
  
  ssim <- ( (2*mux*muy+C1) * (2*sigxy+C2) ) / ( (mux**2+muy**2+C1) * (sigx+sigy+C2) ) # sigx ^2???
  
  stopifnot(ssim >= -1 && ssim <= 1)
  
  return(ssim)
}

SSIM(AA,BB,256) # 0.931958
SSIM(BB,AA,256) # 0.931958

#ssim(AA,BB,256) # 0.931958

require("MLmetrics")
MSE(AA,BB) # 0.03811065
MSE(BB,AA) #  0.03811065

# R2_Score not the same!!

R2_Score(AA,BB) #  0.2650466
R2_Score(BB,AA) #  0.2727839

#install.packages("devtools")
#library(devtools)

#install.packages("SpatialTools")
#install.packages("geepack")
#install.packages("gpclib")
#install.packages("move")
#install.packages("waveslim")

#install_github("colinr23/spatialcompare")

require("spatialcompare")

rAA<-raster(AA)
rBB<-raster(BB)
#w is the width of the neighbourhood in number of pixels out from centre cell

#nrow(AA) [1] 432


msssim <- function(img1, img2, w, gFIL=TRUE, edge=FALSE, ks=c(0.01, 0.03), level=5, weight=c(0.0448, 0.2856, 0.3001, 0.2363, 0.1333), method='product') {
  im1 <- img1
  im2 <- img2
  N <- FALSE
  sssimArray <- list()
  sssimArray[[1]] <- ssim(im1, im2, w, gFIL, edge, ks)
  for(i in 2:level) {
    sigma <- 3.37
    filterx=getGauss(sigma, i)
    im1f <- focal(im1, filterx, fun=sum, na.rm=N) #low pass filter
    im2f <- focal(im2, filterx, fun=sum, na.rm=N)
    im1f <- aggregate(im1f, fact=2) #downsample
    im2f <- aggregate(im2f, fact=2)
    #compute c and s
    sssimArray[[i]] <- ssim(im1f, im2f, w, gFIL, edge, ks)
  }
  if(method =='product') {
    x <- unlist(sssimArray)
    l <- 3 #index of luminance of 1st level
    cs <- seq(4,level*5, by=5) #indices of contrast at all levels
    ss <- seq(5,level*5, by=5) #indices of structure at all levels
    contrasts <- unlist(lapply(unlist(x)[cs], cellStats, mean)) #mean values of contrast component at all levels
    structures <- unlist(lapply(unlist(x)[ss], cellStats, mean)) #mean values of structure component at all levels
  }
  msssimO <- cellStats(x[[3]], mean)^1 *  prod(contrasts^weight, structures^weight)
  return(msssimO)
}


msssim(rAA,rAA,w=5) #1

msssim(rAA,rBB,w=5) #0.8342233
msssim(rBB,rAA,w=5) #0.8342233

msssim(rAA,rBB,w=50) #0.8276595
msssim(rAA,rBB,w=10) 


