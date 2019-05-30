library(reshape2)
SCcdrODM<-acast(rbind(melt(ODout_SH_0_3), melt(ODout_SH_3_6), melt(ODout_SH_6_9), melt(ODout_SH_9_12), 
                      melt(ODout_SH_12_15), melt(ODout_SH_15_18),melt(ODout_SH_18_21),melt(ODout_SH_21_24)), Var1~Var2, sum) 
heatmap(SCcdrODM, col = heat.colors(256), Rowv=NA, Colv=NA) #prekrasna je :')

max(SCcdrODM)# 1757
max(SCcdrODM[SCcdrODM<1757])#396
sum(SCcdrODM)#42831 ->lijep broj

#SCcdrODM dimenzije 646 x 631 (od 1090 baznih stanica)
SSIM(SCcdrODM,cdrODM)

#BORROW FROM matrices_are_not_squared
z<-zeros(nrow(SCcdrODM),ncol(SCcdrODM))
dimnames(z)<-dimnames(SCcdrODM)

cdrODM<-acast(rbind(melt(z), melt(cdrODM)), Var1~Var2, sum)  #izgleda da ne radi kako treba

#SCcdrODM je veći od cdrODM 

SSIM(SCcdrODM,cdrODM,5)  # 0.9807741
SSIM(SCcdrODM,cdrODM,255)#  0.9748741
# apsurdno, zato što su same nule?!

MSE(SCcdrODM,cdrODM) # 0.8241497

# R2_Score not the same!!
R2_Score(SCcdrODM,cdrODM) #  -293.81
R2_Score(cdrODM,SCcdrODM) #  0.0008971753

heatmap(cdrODM, col = heat.colors(256), Rowv=NA, Colv=NA)
