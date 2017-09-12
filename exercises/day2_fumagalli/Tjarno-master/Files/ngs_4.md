
## Sample allele frequencies likelihoods and probabilities

We know that we can gather much more power if we retain the information on the uncertainty of our allele frequencies.
For each population, we are now calculating the sample allele frequency probabilities (what ANGSD calls .saf files).
```
NIND=10
for i in `seq 1 2`; do $ANGSD/angsd -glf Data/pop$i.glf.gz -ref Data/ref.fa -fai Data/ref.fa.fai -isSim 1 -nInd $NIND -doMajorMinor 4 -doMaf 1 -doSaf 1 -out Results/pop$i; done
```

Let's inspect these .saf files (for instance for population 1):
```
$ANGSD/misc/realSFS print Results/pop1.saf.idx | less -S
```

**QUESTION**
What are these values?
Can you identify any SNP?

-------------------------------------------------------------

## Summary statistics

From these probabilities we can calculate the expected values of many summary statistics.
For instance, we can calculate the expected number of polymorphic sites in our region, in both populations separately.
For doing that, let's calculate the probability of each site being variable (for instance, for the first 1,000 sites).
```
NSITES=1000
NIND=10

for i in `seq 1 2`; do zcat Results/pop$i.saf.gz > Results/pop$i.saf; $NGSTOOLS/ngsPopGen/ngsStat -npop 1 -postfiles Results/pop$i.saf -outfile Results/pop$i.stats -nind $NIND -nsites $NSITES -iswin 0; done
```

**QUESTION**
If you look at them:
```
less -S Results/pop1.stats
```
are these values consistent with the sample allele frequency likelihoods?
What's annoying here?

------------------------------------------------------------------------------

**QUESTION**
If you calculate the expected number of polymorphic sites (use `-iswin 1 -block_size $NSITES`), do you obtain sensible value?
```
i=1
$NGSTOOLS/ngsPopGen/ngsStat -npop 1 -postfiles Results/pop$i.saf -outfile Results/pop$i.whole.stats -nind $NIND -nsites $NSITES -iswin 1 -block_size $NSITES
cat Results/pop$i.whole.stats
```
How can we solve this?

--------------------------------------------------------------------

## SFS

We can estimate the site frequency spectrum (SFS) to be used as prior information.
Let's calculate the SFS for each population separately.
```
for i in `seq 1 2`; do $ANGSD/misc/realSFS Results/pop$i.saf.idx > Results/pop$i.sfs; done
```

**QUESTION**

How many values do you expect?

Open the files:
```
i=1
cat Results/pop$i.sfs
```
What do these values represent? Check the ANGSD manual to understand the format of this file.

We can parse this file to plot the SFS for each population:
```
Rscript $NGSTOOLS/Scripts/plotSFS.R Results/pop1.sfs-Results/pop2.sfs EAS-NAM 0 Results/pops.sfs.pdf
evince Results/pops.sfs.pdf
```

**QUESTION**

Do they behave as expected (given what we know about human evolution)?

----------------------------------------------------------------------

## Genetic diversity

Now we can use such SFS as prior information to improve our estimation of genetic diversity.
Let's calculate some diversity indexes.
```
NIND=10
for i in `seq 1 2`; do $ANGSD/angsd -glf Data/pop$i.glf.gz -ref Data/ref.fa -fai Data/ref.fa.fai -isSim 1 -nInd $NIND -doSaf 1 -doThetas 1 -pest Results/pop$i.sfs -out Results/pop$i; $ANGSD/misc/thetaStat do_stat Results/pop$i.thetas.idx; done
```

Open the file and look at the corresponding value for each index:
```
cat Results/pop?.thetas.idx.pestPG
```

**QUESTION**

Can you make any comment on the valyes of Theta and Tajima'sD obtained for the two populations?
Are these values in line with what we were expecting?

------------------------------------------------------------------------------------

**EXERCISE**

You can calculate diversity indexes in sliding windows too.
Look at ANGSD manual and ngsTools tutorial to see how you can achieve that.
It is very important that you also learn how to get information from sometimes messy and confusing manuals, like these ones!
More importantly, looking for local variation in diversity may pinpoint some regions which deviate from neutral evolution.
These regions should be typically ignore for demography reconstruction.
A solution to this exercise will appear at some point.

-----------------------------------------------------------------------------------

## 2D-SFS

We now want to estimate a multi-dimensional SFS, for instance the joint SFS between 2 populations (2D). 
This can be used for making inferences on their divergence process (split time, migration rate and so on). 
Here we are interested in estimating the 2D-SFS as prior information for our FST estimation.

An important issue when doing this is to be sure that we are comparing the exactly same corresponding sites between populations.
ANGSD does that automatically and considers only a set of overlapping sites.
```
$ANGSD/misc/realSFS Results/pop1.saf.idx Results/pop2.saf.idx > Results/pops.2dsfs
```

**QUESTIONS**
How does the resulting file look like?
```
less -S Results/pops.2dsfs
```
What do the values represent?

The output file is a flatten matrix, where each value is the count of sites with the corresponding joint frequency ordered as [0,0] [0,1] and so on.

You can plot it, but you need to define how many samples (individuals) you have per population.
```
Rscript $NGSTOOLS/Scripts/plot2DSFS.R Results/pops.2dsfs EAS-NAM 10-10
evince Results/pops.2dsfs.pdf
```

**QUESTION**

Comment on the 2D SFS.
What would you get if you had two populations very close to each other?
```
$ANGSD/misc/realSFS Results/pop1.saf.idx Results/pop1.saf.idx > Results/fake.2dsfs
Rscript $NGSTOOLS/Scripts/plot2DSFS.R Results/fake.2dsfs EAS-EAS 10-10
evince Results/fake.2dsfs.pdf
```

----------------------------------------------------------------------

A nice summary statistics to quantify the 2D-SFS is FST, index of population genetic differentiation.
```
$ANGSD/misc/realSFS fst index Results/pop1.saf.idx Results/pop2.saf.idx -sfs Results/pops.2dsfs -fstout Results/pops

$ANGSD/misc/realSFS fst print Results/pops.fst.idx | less -S

$ANGSD/misc/realSFS fst stats Results/pops.fst.idx
```




