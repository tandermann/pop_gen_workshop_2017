

## Preparation

Please make sure to follow these preparatory instructions.

Create some folders where you will put your results and data.
```
mkdir Data
mkdir Results
```

You will need several software (which I'll explain later) for these exercises.
You should be able to load them on the server with:
```
module load msms/v3.2rc-b163

module load samtools/v1.3.1

module load angsd/v0.918

module load ngsTools/vX.X
```

In case it fails, follow these instructions:

* msms
```
wget http://www.mabs.at/ewing/msms/msms3.2rc-b163.zip
unzip msms3.2rc-b163.zip
chmod +x ./msms/bin/msms
```
You need to have java installed, if not `sudo apt-get install default-jre`.

* samtools
```
sudo apt-get install samtools
```

* ANGSD
```
wget http://popgen.dk/software/download/angsd/angsd0.918.tar.gz
tar xf angsd0.918.tar.gz
cd htslib;make;cd ..
cd angsd
make HTSSRC=../htslib
cd ..
```

* ngsTools
```
git clone --recursive https://github.com/mfumagalli/ngsTools.git
cd ngsTools
make
cd ..
```
Don't worry if you get an error at compiling `ngsDist`, as we won't use it today.

-------------------------------------------------------------------------

Then you have to create variables to store the path to these software.
For instance, these are mine:
```
MS=~/Software/msms/bin/msms
SAMTOOLS=samtools
ANGSD=~/Software/angsd
NGSTOOLS=~/Software/ngsTools
```

We are using the software [msms](http://www.mabs.at/ewing/msms/download.shtml) to perform coalescent simulations under neutrality (and with selection, as we will see later).
Please follow the link to get the manual, if interested (but not required).

We also use a model previously estimated [here](http://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1000695) for the evolution of Africans, Europeans and East Asians.

We are adding the history of Native Americans to this model, roughly following estimates reported in [this](http://www.ncbi.nlm.nih.gov/pubmed/26198033) paper.
Thus, we will assume that Native Americans (their ancestors) splitted from East Asians 20kya and their effective population size is 2,000 from the split until present.

For most of the examples, we will use the program [ANGSD](http://popgen.dk/wiki/index.php/ANGSD) (Analysis of Next Generation Sequencing Data) developed by Thorfinn Korneliussen and Anders Albrechtsen (and many contributors) at the University of Copenhagen.
More information about its rationale and implemented methods can be found [here](http://www.ncbi.nlm.nih.gov/pubmed/25420514).

According to its website *ANGSD is a software for analyzing next generation sequencing data. The software can handle a number of different input types from mapped reads to imputed genotype probabilities. Most methods take genotype uncertainty into account instead of basing the analysis on called genotypes. This is especially useful for low and medium depth data. The software is written in C++ and has been used on large sample sizes. This program is not for manipulating BAM/CRAM files, but solely a tool to perform various kinds of analysis. We recommend the excellent program SAMtools for outputting and modifying bamfiles.*

## Simulation

We are now simulating some genomic data (2Mbp) for 2 populations of 10 diploid individuals each.

We can generate such data using msms with the following command:
```
$MS -ms 40 1 -t 1500 -r 1500 2000000 -I 4 0 0 20 20 -n 1 1.68 -n 2 3.73 -n 3 7.29 -n 4 0.25 -eg 0 2 116 -eg 0 3 160 -ma x 0.88 0.56 0.00 0.88 x 2.79 0.00 0.56 2.79 x 0.00 0.00 0.00 0.00 x -ej 0.027 4 3 -ej 0.029 3 2 -en 0.029 2 0.29 -en 0.30 1 1 -seed 1234 > Data/pops.ms
```
It's not really important how this line has been generated.
However it is interesting to have a look at the output file.
```
less -S Data/pops.ms
```

**QUESTION** What do these 0s and 1s represent?

Since we didn't simulated actual nucleotides but rather an arbitrary dichotomoy of alleles, we need to provide at the least the information on the reference (or ancestral state).
Let's produce a reference sequence (with all As) and index it using samtools:
```
Rscript -e 'cat(">ref\n",paste(rep("A",2e6),sep="", collapse=""),"\n",sep="")' > Data/ref.fa 
$SAMTOOLS faidx Data/ref.fa
```

We simulated genomic data based on our demographic model for both populations.
Now we need to simulate sequencing data.
Specifically we want to replicate the sequencing experiment given the known genomic sequences we simulated.

There are some parameters, which depend on your experiment, that we need to set.
For instance, you can set the average depth per site per sample (pick sometyhing between 2 and 8) and the sequencing error rate (between 0.1% and 1%?).

This is a possible choice, but you can explore other scenarios, depending whether you are brave or tame...
We use a utility in ANGSD to sumulate sequencing reads based on these parameters.
```
DEPTH=4
ERR=0.0075
$ANGSD/misc/msToGlf -in Data/pops.ms -out Data/pops -regLen 2000000 -singleOut 1 -depth $DEPTH -err $ERR -pileup 0 -Nsites 0 -seed 1234
```
Then we have to split the results into two populations:
```
$ANGSD/misc/splitgl Data/pops.glf.gz 20 1 10 > Data/pop1.glf.gz 
$ANGSD/misc/splitgl Data/pops.glf.gz 20 11 20 > Data/pop2.glf.gz 
```

**QUESTION** Have a look at all files generated by $ANGSD/misc/msToGlf. Can you understand what kind of information they contain?

## Genotype likelihoods and probabilities

The most intuitive way to look at these genotype likelihoods (stored in the binary .glf.gz files) is to calculate posterior probabilities using a uniform flat prior.
We will focus only on the 3 possible genotypes after having inferred the two most likely alleles.

We can do that using ANGSD.
If you type:
```
$ANGSD/ansgd
```
you will see a list of options.

Moreover, if you type:
```
$ANGSD/angsd -doGeno
```
you will have a list of options for calculating genotype probabilities and call genotypes, while
```
$ANGSD/angsd -doMajorMinor
```
will tell you the available methods to assign the two most probable alleles.

**EXERCISE!!!**

Assuming that this is the backbone of your command line (you can't copy and paste this):
```
NIND=20
$ANGSD/angsd -glf Data/pops.glf.gz -ref Data/ref.fa -fai Data/ref.fa.fai -isSim 1 -nInd $NIND -doMajorMinor ??? -doMaf 1 -doPost ??? -doGeno ??? -out Results/pops.flat
```
try to assign the most appropriate value for each parameter set as '???' by looking at the help pages `$ANGSD/angsd -doGeno` and `$ANGSD/angsd -doMajorMinor`.
For instance, assume that (i) you want one of the two alleles to be the reference one (hint: look at -doMajorMinor), (ii) you want to calculate genotype posterior probabilities using a uniform prior (hint: look at -doPost), (iii) you want to print out the called genotype AND the posterior probabilities for all 3 possible genotypes (hint: look at -doGeno).
A possible solution can be found [here](https://github.com/mfumagalli/Tjarno/blob/master/Files/ngs_1_solution.md).

----------------------------------------------------------------------------------

One you defined your parameters, then you can launch the command.
The genotypes' information will be shown in the `pops.flat.geno.gz` file.
Open the file and search for low probabilities or missing data.
```
less -S Results/pops.flat.geno.gz
```

**QUESTION** Can you identify any missing data (aka genotypes not assigned)? Why are they there?






