load("/home/adminuser/Desktop/masters-thesis/data/zCDR_and_TAXI_ODMs.RData")

A_0_24 = zODout_SH_0_3 + zODout_SH_3_6+(zODout_SH_6_9)+zODout_SH_9_12+zODout_SH_12_15+zODout_SH_15_18+zODout_SH_18_21+zODout_SH_21_24 # 30878
B_0_24 = TAXI_SH_0_3+TAXI_SH_3_6+TAXI_SH_6_9+TAXI_SH_9_12+TAXI_SH_12_15+TAXI_SH_15_18+TAXI_SH_18_21+TAXI_SH_21_24 # 427646


A <- zODout_SH_0_3 # T = 1 d, t = 3h 
B <- TAXI_SH_0_3   # T = 1 d, t = 3h 

k=2
m=1

#Prostorno obuhvaćanje
A # + (neovisno o infrastrukturi)
B # (samo cest, samo taksi)

#Prostorna zrnatost
size(A) # 1090 1090
size(B) # 1090 1090

#Vremenska zrnatost
# t(A) = 3h, Z(A) = 3/24 = 8
# t(B) = 3h, Z(B) = 3/24 = 8

#Ukupna Širina Toka 0_24
sum(A_0_24) # 30878
sum(B_0_24) # 427646
# 30878
# 427646

  #Ukupna Širina Toka 0_3
  sum(A) # 3875
  sum(B) # 43201 +

#Gustoća informacija 0_24
length(A_0_24[A_0_24>0])/length(A_0_24[A_0_24==0]) #  0.008830772
length(B_0_24[B_0_24>0])/length(B_0_24[B_0_24==0]) #  0.08683223 +
  
  #Gustoća informacija | k = 2, m = 1
  length(A_0_24[A_0_24>0])/(length(A_0_24[A_0_24==0]) + length(A_0_24[A_0_24 < (k*m)]))#  0.004404717 | k=2
  length(B_0_24[B_0_24>0])/(length(B_0_24[B_0_24==0]) + length(B_0_24[B_0_24 < k*m]))  #  0.04236616  | k=2 +
  
  #Gustoća informacija 0_3
  length(A[A>0])/length(A[A==0]) #  0.002246429
  length(B[B>0])/length(B[B==0]) #  0.01612753 +
  
    #Gustoća informacija | k = 2, m = 1
    length(A[A>0])/(length(A[A==0]) + length(A[A < (k*m)]))#  0.001122245 | k=2
    length(B[B>0])/(length(B[B==0]) + length(B[B < k*m]))  #  0.008014788 | k=2 +

ran = c(A_0_24) 
#col_breaks = seq (0, max(ran),length = 5)
#colPal = colorRampPalette(c('red'))(4)
#colPal = gray((1:4)/6)
#colPal = rgb((1:4)/4, 0, 0)
#colPal = rainbow(4, start = 0, end = 0.25)
#heatmap(A_0_24, Colv = NA, Rowv = NA, main = "A_0_24", breaks = col_breaks, col = colPal)

#ran = c(B_0_24) 
#col_breaks = seq (0, max(ran),length = 5)
#colPal = colorRampPalette(c('red'))(4) -> sve ista boja, crvena!
#heatmap(B_0_24, Colv = NA, Rowv = NA, main = "B_0_24", breaks = col_breaks, col = colPal)

  #my.breaks <-c(0,1,5,10,20,30,40,50,100)
  #my.breaks <-c(0,1,5,10,20,30,40,50,100)
  #my.col=c("white","red","green")

  #https://cran.r-project.org/web/packages/unikn/vignettes/colors.html
  #require(unikn)
  #colPal  = usecol(pal_unikn, n = 10)
  #col_breaks = seq (0, max(ran),length = 12)

col_breaks <-c(0,1,2,5,10,15,20,30,40,50,max(A_0_24))
colPal = rainbow(10, start = 0, end = 0.25)
heatmap(A_0_24, Rowv=NA, Colv=NA, main = "A_0_24", breaks =col_breaks, col = colPal, scale="none", margins=c(10,10))
heatmap(B_0_24, Colv = NA, Rowv = NA, main = "B_0_24", breaks = col_breaks, col =colPal, scale="none", margins=c(10,10))

heatmap(A_0_24, Rowv=NA, Colv=NA, main = "A_0_24", breaks =col_breaks, col = hcl.colors(10, "YlOrRd", rev = TRUE), scale="none", margins=c(10,10))
heatmap(B_0_24, Colv = NA, Rowv = NA, main = "B_0_24", breaks = col_breaks, col =hcl.colors(10, "YlOrRd", rev = TRUE), scale="none", margins=c(10,10))
#RdYlBu
#YlOrRd

#require("apcluster")
#heatmap(A_0_24, Rowv=NA, Colv=NA, main = "A_0_24", breaks =col_breaks, col = hcl.colors(10, "YlOrRd", rev = TRUE), scale="none", margins=c(10,10))
#heatmap(B_0_24, Colv = NA, Rowv = NA, main = "B_0_24", breaks = col_breaks, col =hcl.colors(10, "YlOrRd", rev = TRUE), legend="col", scale="none", margins=c(10,10))

require(gplots)
col_breaks = seq (1, max(ran),length = 100)

col_breaks <-c(0,1,2,5,10,15,20,30,40,50,100,max(A_0_24))
col = c("#000000",hcl.colors(10, "RdYlBu", rev = TRUE))

heatmap.2(A_0_24, Rowv=NA, Colv=NA, dendrogram = "none", scale="none", 
          breaks =col_breaks, col = col, density.info="none", trace="none",  
          labRow = FALSE, labCol = FALSE, key=TRUE, key.title=NULL, 
          lmat = rbind(c(2,4),c(3,1)), lhei = c(0.75,3), lwid = c(2,10), key.xlab="širina toka")

#col_breaks <-c(0,5,25,50,100,250,500,750,1000,1500,2000,3716) #3716 je 4. najveći rezultat
#col = c("#000000",hcl.colors(10, "RdYlBu", rev = TRUE))

heatmap.2(B_0_24, Rowv=NA, Colv=NA, dendrogram = "none", scale="none", 
          breaks =col_breaks, col = col, density.info="none", trace="none",  
          labRow = FALSE, labCol = FALSE, key=TRUE, key.title=NULL, 
          lmat = rbind(c(2,4),c(3,1)), lhei = c(0.75,3), lwid = c(2,10), key.xlab="širina toka")