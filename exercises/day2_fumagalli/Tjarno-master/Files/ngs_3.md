 
## Allele frequencies

Suppose we now want to estimate the allele frequency at each site.
In other words, at each site we want to to estimate (or count) how many copies of different alleles (two in case of biallelic variants) we observe in our sample (across all sequenced individuals).
However with low depth data direct counting of individually assigned genotypes can lead to biased allele frequencies.

ANGSD has an option to estimate allele frequencies taking into account data uncertainty from genotype likelihoods:
```
$ANGSD/angsd -doMaf
```
Therefore, the estimation of allele frequencies requires the specification of how to assign the major and minor alleles (if biallelic).
```
$ANGSD/angsd -doMajorMinor
```

A possible command to calculate allele frequencies (for one population) is:
```
$ANGSD/angsd -glf Data/pop1.glf.gz -ref Data/ref.fa -fai Data/ref.fa.fai -isSim 1 -nInd 10 -doMajorMinor 4 -doMaf 1 -out Results/pop1
```

**QUESTION**
What are the output files?

`.args` file is a summary of all options used, while `.mafs.gz` file shows the allele frequencies computed at each site.

Have a look at this file which contains estimates of allele frequency values:
```
zcat Results/pop1.mafs.gz | head
```
where `knownEM` specifies the algorithm used to estimate the allele frequency which is given under that column.
Please note that this refers to the allele frequency of the allele labelled as `minor`.
The columns are: chromosome, position, major allele, minor allele, reference allele, allele frequency, p-value for SNP calling (if -SNP-pval was called), number of individuals with data.
The last column gives the number of samples with data.

You can notice that many sites have low allele frequency, probably reflecting the fact that many sites are monomorphic.
We may be interested in looking at allele frequencies only for sites that are actually variable in our sample.
Therefore we want to perform a SNP calling.
There are two main ways to call SNPs using ANGSD with these options:
```
        -minMaf         0.000000        (Remove sites with MAF below)
        -SNP_pval       1.000000        (Remove sites with a pvalue larger)
```
Therefore we can consider assigning as SNPs sites whose estimated allele frequency is above a certain threhsold (e.g. the frequency of a singleton) or whose probability of being variable is above a specified value.

**EXERCISE!!!**

Recalling our previous attempt with PCA, can we do even better?
Can you use the information on the estimated allele frequencies to ameliorate our inferences of population structure?
For instance, we can (i) use the estimates of allele frequencies to filter out sites which are likely to be monomorphic (hint: look at -minMaf option in ANGSD) and (ii) use the estimates of allele frequencies as prior information on our genotype probabilities (e.g. assuming HWE, hint: look at -doPost options).
A possible solution is available [here](https://github.com/mfumagalli/Tjarno/blob/master/Files/ngs_3_solution.md).

