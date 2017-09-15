args <- commandArgs(TRUE)
tot=length(args)
legendvec=vector(length=tot-1)
chr=eval(parse(text=args[1]))

pdf(paste(args[2], "_theta_plot.pdf", sep=""),height=50,width=15)
par(mfrow=c(22,1))
for(c in chr){
	colors=c("#000000",rainbow(tot-2))
	plot('', type="n", xlim=c(0, 2.5e+8), ylim=c(1e-5,0.025),log='y',xlab="Chromosome position",main=paste("Chr=",c,sep=''), yaxt='n') #ylab=expression("Estimated "*theta)
	labelsY1=parse(text=paste(c(1,1,1,1),"%*%","10^",c(-5,-4,-3,-2), sep=""))
	axis(2, at=c(10^-5, 10^-4, 10^-3, 10^-2), labels=labelsY1, las=2)

	for (i in (2:tot)){
		a0<-read.delim(paste(args[i], "_theta_estimates.txt", sep=''))
		a0<-na.omit(a0)
		a0.1<-subset(a0,Chr==c|Chr==paste("chr",c,sep=''))
		lines(a0.1$start,a0.1$theta_MLE,type='l',col=colors[i-1])
		abline(h=median(subset(a0.1,theta_MLE>0)$theta_MLE),lty=2,col=colors[i-1])
		base=basename(args[i])
		legendvec[i-1]=strsplit(base,split="[_.]+")[[1]][1]
	}

	legend("bottomleft",legend=legendvec,col=colors,lty=rep(1,tot-1),lwd=rep(1.5,tot-1),horiz=T)
}
dev.off()

#warnings()
