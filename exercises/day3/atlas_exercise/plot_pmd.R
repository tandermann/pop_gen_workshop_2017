require(stringr)

args <- commandArgs(TRUE)
file <- args[1]

#open files
t_emp <- read.table(paste(file,"_PMD_input_Empiric.txt", sep=''))
t_exp <- read.table(paste(file,"_PMD_input_Exponential.txt", sep=''))

#functions
extractDoubles <- function(s) { return(as.numeric(unlist(str_extract_all(s, '-?[0-9.]+e?[-+]?[0-9]*')))) }
pmd <- function(x,a,b,c){ return(a*exp(-x*b)+c) }

num_RG <- length(t_emp$V1)

#fill lists
l_emp_fwd <- list()
l_emp_rev <- list()
for(i in 1:num_RG){
emp_fwd <- extractDoubles(t_emp$V2[i])
emp_rev <- extractDoubles(t_emp$V3[i])
l_emp_fwd[[i]] <- emp_fwd
l_emp_rev[[i]] <- emp_rev
}

num_pos <- length(l_emp_fwd[[1]])

#define plotting parameters
n_row <- ceiling(num_RG / 5)
pdf(paste(file, "_pmdPlot.pdf", sep=''), width=20, height=n_row*4)
par(mfrow=c(n_row, 5))
CEX <- 1.5

#plot
for(i in 1:num_RG){
plot(1:num_pos, rep(0, num_pos), type="l", xlim=c(1,num_pos), ylim=c(0, 0.7), lwd=0.1, xlab="", ylab='',         yaxs='i', main=t_emp$V1[i], cex.axis=CEX)
mtext("Mismatch rate", side=2, line=2.5)
mtext("Position in read", side=1, line=2.5)

#empiric
lines(1:num_pos, l_emp_fwd[[i]], col="red", lty=2, pch=20, type="b")
lines(num_pos:1, l_emp_rev[[i]], col="blue", lty=2, pch=20, type="b")

#exponential
exp_fwd <- extractDoubles(t_exp$V2[i])
exp_rev <- extractDoubles(t_exp$V3[i])
lines(x=1:num_pos, y=pmd(1:num_pos, exp_fwd[1], exp_fwd[2], exp_fwd[3]), col="red", lwd=2)
lines(x=1:num_pos, y=pmd(num_pos:1, exp_rev[1], exp_rev[2], exp_rev[3]), col="blue", lwd=2)
}
legend("topleft", c("C>T", "G->A", "emp", "exp"), col=c("red", "blue", "black", "black"), text.col=c("red",     "blue", "black", "black"), text.width=c(8,8,9,9), cex=CEX, seg.len=1, x.intersp = 0.3, pch=c(20,20,NA,NA),     lty=c(NA,NA,2,1), bty="n", horiz=T)

dev.off()
