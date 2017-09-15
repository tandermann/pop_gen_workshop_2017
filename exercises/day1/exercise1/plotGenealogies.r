#load library to work with tree is R
library(ape); 

#read trees
args <- commandArgs(trailingOnly=TRUE);
t<-read.nexus(args[1]);
numTrees <- length(t);
print(paste("Plotting ", numTrees, " genealogies from file '", args[1], "'", sep=""));

#get tallest tree among first 5 to adjust plotting area
maxHeight <- 0;
for(i in 1:numTrees){
  maxThisTree <- max(branching.times(t[[i]]));
  if(maxThisTree > maxHeight){ maxHeight <- maxThisTree; }  
}

#plot first five trees
pdf("genealogies.pdf", width=8, height=5)
par(mfrow=c(1,numTrees), mar=c(0.5,0.5,0.5,0.5), oma=c(0,3,0,0))
for(i in 1:numTrees){
  plot.phylo(t[[i]], direction="downwards", show.tip.label=F, y.lim=c(0, maxHeight))
  if(i==1){ axis(side=2, outer=T); }  
}  
dev.off();






