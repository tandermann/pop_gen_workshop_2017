args <- commandArgs(TRUE)
file <- args[1]

x<-read.table(paste(file,"_qualityTransformation.txt",sep=''))[,-1]
z<-as.matrix(x)[-1,]
color = function(x)rev(heat.colors(x))
vbreaks=c(1e-6,1e-5,1e-4,1e-3,1e-2,1e-1)
cex.par=1.5

pdf(paste(file, "_qualityTrandformation.pdf", sep=''), height=8, width=8)

image(c(1:100),c(1:100),z,col=color(length(vbreaks)-1),breaks=vbreaks,xlab="original quality/recal  quality",ylab="recalibrated quality/recal2 quality/BQSR quality",
xlim=c(0,45),ylim=c(0,45),main=file,cex.lab=cex.par,cex.axis=cex.par,cex.main=cex.par)
lines(c(0,100),c(0,100),lty=2)

dev.off()
