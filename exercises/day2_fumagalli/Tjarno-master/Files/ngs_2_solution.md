
```
$NGSTOOLS/ngsPopGen/ngsCovar -probfile Results/pops.flat.bin.geno -outfile Results/pops.probs.covar -nind $NIND -nsites $NSITES -call 0 -norm 0

Rscript -e 'write.table(cbind(rep(seq(1,10),2),rep(seq(1,10),2),c(rep("EAS",10),rep("NAM",10))), row.names=F, sep="\t", col.names=c("FID","IID","CLUSTER"), file="Results/pops.clst", quote=F)'

Rscript $NGSTOOLS/Scripts/plotPCA.R -i Results/pops.probs.covar -a Results/pops.clst -c 1-2 -o Results/pops.probs.pca.pdf

evince Results/pops.probs.pca.pdf

Rscript $NGSTOOLS/Scripts/plotPCA.R -i Results/pops.probs.covar -a Results/pops.clst -c 3-4 -o Results/pops.probs2.pca.pdf

evince Results/pops.probs2.pca.pdf

```
