ssim <- function(img1, img2, w, gFIL=TRUE, edge=FALSE, ks=c(0.01, 0.03)) {

  
  #set constants
  N <- FALSE
  library(raster)
  
  L <- max(cellStats(img1, max), cellStats(img2, max))
  globalMin <- abs(min(cellStats(img1, min), cellStats(img2, min)))
  L <- L - globalMin
  K <- ks
  C1 <-(K[1]*L)^2
  C2 <-(K[2]*L)^2
  C3 <-C2/2
  
  sigma = 1.5
  #create null filter, optionally replace with weighted version
  filterx=matrix(1, nrow=(w*2)+1, ncol=(w*2)+1) / sum(matrix(1, nrow=(w*2)+1, ncol=(w*2)+1))
  #get the Gaussian Kernel
  if(gFIL == TRUE) {
    filterx=getGauss(sigma, w)
  }
  #get mu
  mu1 <- focal(img1, filterx, fun=sum, na.rm=N)
  mu2 <- focal(img2, filterx, fun=sum, na.rm=N)
  img12 <- img1 * img2
  #square
  mu1mu2 <- mu1 * mu2
  mu1sq <- mu1 * mu1
  mu2sq <- mu2 * mu2
  #normalized sigma sq
  sigsq1<- focal(img1*img1,filterx,fun=sum, na.rm=N) - mu1sq
  sigsq2<- focal(img2*img2,filterx,fun=sum, na.rm=N) - mu2sq
  sig12 <- focal(img1*img2,filterx,fun=sum, na.rm=N) - mu1mu2
  #std dev
  sig1 <- sigsq1 ^ 0.5
  sig2 <- sigsq2 ^ 0.5
  #compute components
  L <- ((2*mu1mu2)+C1) / (mu1sq + mu2sq + C1)
  C <- (2*sig1*sig2+C2) / (sigsq1 + sigsq2 + C2)
  S <- (sig12 + C3) / (sig1 * sig2 + C3)
  #compute SSIMap
  SSIM2 <- L * C * S
  
  #compute SSIM
  num <- (2*mu1mu2+C1)*(2*sig12+C2)
  denom <- (mu1sq+mu2sq+C1) * (sigsq1+sigsq2+C2)
  #global mean
  mSSIM <- cellStats((num / denom), mean)
  return(list(mSSIM, SSIM2, L, C, S))
}

ssim(rAA,rBB,5) #0.9466467 /NAN

msssim <- function(img1, img2, w, gFIL=TRUE, edge=FALSE, ks=c(0.01, 0.03), level=5, weight=c(0.0448, 0.2856, 0.3001, 0.2363, 0.1333), method='product') {
  im1 <- img1
  im2 <- img2
  N <- FALSE
  sssimArray <- list()
  sssimArray[[1]] <- ssim(im1, im2, w, gFIL, edge, ks)
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

