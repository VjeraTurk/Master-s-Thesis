taxiODM<-OD_0_24_SH
taxiODM[rowSums(taxiODM)!=0]
taxiODM[colSums(taxiODM)!=0]

#241462
x<-ODout_SH_3_6[rowSums(ODout_SH_3_6)==0]
x<-ODout_SH_3_6[colSums(ODout_SH_3_6)==0]

#x ne postoje takvi reci i stupci ->pobriši iz taxi

#455625
x<-taxiODM[rowSums(taxiODM)!=0 & colSums(taxiODM)!=0]

#280125

#1188100
y<-OD_0_24_SH[rowSums(OD_0_24_SH)!=0 & colSums(OD_0_24_SH)!=0]
#576610

library(dplyr)
intersection = intersect(LonLat_CDR, LonLat_SC)
intersection = intersect(x,y)
