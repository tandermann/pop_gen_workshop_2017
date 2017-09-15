#!/bin/bash
# 
# -----------------------------------------------------------
# Exercise 1: Simulating genealogies with fastsimcoal
# -----------------------------------------------------------
# Steps:
#   1) Get latest version of fastsimcoal
#   2) Generate some simulatiosn with fastsimcoal
#   3) Simulate and plot genealogies
#   4) Simulating an expanding population
#   5) Simulating two populations with migration
#   6) Calculating summary statistics with arlsumstat
#   7) Calculating summary statistics r a divergence model

# 
# To see the individual steps, type './ex1.sh STEP', where STEP is the number of the desired step.
# 

#1 
#1 Step 1: Get latest version of fastsimcoal
#1 ------------------------------------------
#1 - Let us begin by creating a directory "bin" for all executables (binaries) of programs you will use. Then enter that directory.
#1 
#1 > mkdir bin
#1 > cd bin
#1 
#1 - To generate simulations, we will use fastsimcoal (version 2.5.2.2.1 = executable fsc25221). You can get a compiled copy of the latest version using wget inside the bin folder.
#1 
#1 > wget http://cmpg.unibe.ch/software/fastsimcoal2/downloads/fsc_linux64.zip
#1 
#1 - In order to use fastsimcoal, unzip the archive.
#1 
#1 > unzip fsc_linux64.zip
#1 
#1 - Then copy the fstsimcoal esecutable into the bin folder and make sure it is executable.
#1 
#1 > cp fsc_linux64/fsc25221 .
#1 > chmod +x fsc25221
#1 
#1 - Finally, and to have easy access to these executables, add the bin folder to your PATH. Note that you need to adjust the command below to take care of the location of which you copied the files of thus exercise (replace the placeholder LOCATION in the command below with the full path to the bin folder. You can get the full path using the command pwd inside the bin folder).
#1 
#1 > PATH="LOCATION:${PATH}"
#1 
#1 - You can easily test if that worked. Simply try to launch one of the programs from another directory:
#1 
#1 > cd ..
#1 > fsc25221
#1 

#2
#2 Step 2: Generate some simulatiosn with fastsimcoal
#2 ---------------------------------------------------
#2 - fastsimcoal requires an input file specifying the model, and we will use here the file constSize.par. Have a look at that file and locate the two important parameters i) population size and ii) the sample size. You may also consult the manual of fastsimcoal, which is available here: http://cmpg.unibe.ch/software/fastsimcoal2/man/fastsimcoal25.pdf
#2 - Use the following command to generate the simulations (run fsc25221 without arguments to get some help):
#2 
#2 > fsc25221 -i constSize.par -n 1
#2 
#2 - Note: -n 1 implies that a single simulation is conducted.
#2 
#2 - fastsimcoal will generate a directory with the same name as the input will. In that directory you will find a file with the ending .arp, which contains the simulated data. Have a look at it!
#2 

#3 
#3 Step 3: Simulate and plot genealogies
#3 --------------------------------------
#3 - We can also tell fastsimcoal to output the simulated genealogy by adding the argument -T
#3 
#3 > fsc25221 -i constSize.par -n 1 -T
#3 
#3 - If you run fastsimcoal this way you will find two files with the simulated genealogies in Newick format (both ending in .trees). Teh difference is how branch length are calculated: either it is the distance in generation (the true_trees file), or in mutations (the mut_trees file). Have a look at them!
#3  
#3 - We will next try to get a sense of the variation in genealogies among independent sites. For this, generate five genealogies as follows:
#3 
#3 > fsc25221 -i constSize.par -n 5 -T
#3 
#3 - Now use the provided R script to plot those trees as a pdf
#3 
#3 > Rscript plotGenealogies.r constSize/constSize_1_true_trees.trees
#3 
#3 - Look at the trees and appreciate their variability! You may generate additional trees to see even more variation among them by repeating the last two commands.
#3 

#4 
#4 Step 4: Simulating an expanding population
#4 -------------------------------------------
#4 - Next you will now start changing the par file to simulate other model. Let's start by simulating an expanding population. For this, first copy the par file:
#4 
#4 > cp constSize.par expanding.par
#4 
#4 - Then modify that file by 1) making the population size larger (say to 100,000) and 2) adding a negative growth rate (say -1.5). Note that fastsimcoal runs backward in time, so a negative growth rate implies an expansion forward in time. Now generate genealogies with this new par file and plot them.
#4 
#4 > fsc25221 -i expanding.par -n 5 -T
#4 > Rscript plotGenealogies.r expanding/expanding_1_true_trees.trees
#4 
#4 - How do the genealogies look like?
#4 

#5 
#5 Step 5: Simulating two populations with migration
#5 --------------------------------------------------
#5 - Next try to create a par file that will simulate two populations that exchange migrants. Start again by copying the constSize.par file
#5 
#5 > cp constSize.par migration.par
#5 
#5 - In order to simulate multiple populations, multiple lines have to be changed in the par file:
#5    - The number of populations has to be increased to two
#5    - An additional population size, sample size and growth rate has to be given on an extra line each.
#5    - A migration matrix has to be defined. For this set the number of migration matrices to 1 and provide a matrix like this:
#5 
#5      //Migration Matrix 0
#5      0.000 0.001
#5      0.001 0.000
#5 
#5      which implies a probability of 1% for any lineage to migrate to the other population. Note: that the diagonal will always be 0 (no self-migration) and that the migration matrix is backward in time. So m_ij on row i and column j implies a migration event from population i to population j backward in time. (Plase note: the comment line above the matrix is mandatory!).
#5 
#5 - Now generate some simulations and look at the the trees.
#5 
#5 > fsc25221 -i migration.par -n 5 -T
#5 > Rscript plotGenealogies.r migration/migration_1_true_trees.trees
#5 
#5 - How do the trees look like if the population sizes are small and the migration is also small?
#5 

#6 
#6 Step 6: Calculating summary statistics with arlsumstat
#6 -------------------------------------------------------
#6 - Here we will use the command line version of Arlequin (called arlsumstat) to calculate summary statistics from the output of fastsimcoal. You can get a compiled copy of the latest version (version 3.522) using wget inside the bin folder.
#6 
#6 > wget http://cmpg.unibe.ch/software/arlequin35/linux/arlsumstat_linux.zip
#6
#6 - Again, unzip the folder, copy the executable into the bin folder, and make it executable.
#6 
#6 > unzip arlsumstat_linux.zip
#6 > cp arlsumstat_linux/arlsumstat3522_64bit . 
#6 > chmod +x arlsumstat3522_64bit
#6 
#6 - arlsumstat requires two setting files to run correctly: i) the file arl_run.ars that tells arlsumstats what statistics are to be calculated, ii) ssdefs.txt, which specified what summary statistics to be printed. The files provided here are set to calculate essentially everything possible. Have a look at those file, but note that both files can be generated and modified with the graphical version of Arlequin.
#6 - To run arlsumstat on the generated data, use the following command line (run arlsumstat without arguments to get some help on the arguments):
#6 
#6 > arlsumstat3522_64bit migration/migration_1_1.arp migration_stats.txt 0 1
#6 
#6 - The results are written to the file migration_stats.obs. Have a look at it! Does the Fst fit the expectation? Try different population sizes and migration rates to verify.
#6 - Since statistics calculated at a single locus (and hence from a single genealogy) are very noisy, try to increase the number of loci. You can achieve this by setting 
#6 
#6     //Number of independent loci [chromosome] 
#6     100 0
#6 
#6   which will imply 100 independent loci with the same configuration (10Kb of DNA sequence with mutation rate 1.2*10^-8).
#6 - Does the FST now match the expecation?
#6 

#7 
#7 Step 7: Calculating summary statistics r a divergence model
#7 ------------------------------------------------------------
#7 - Finally let us simulate data under a pure divergence model. Again start by copying the par file, but let's use teh migration model as basis.
#7 
#7 > cp migration.par divergence.par
#7 
#7 - In order to simulate a divergence model, you will need to:
#7    - Remove the migration matrix
#7    - Add a historical event like this:
#7 
#7      1  historical event 
#7      10000 1 0 1 1 0 0
#7 
#7    where the numbers imply:
#7      1) the time of the event (1000 generatiosn before present)
#7      2) the source population (population 1)
#7      3) the sink population (0)
#7      4) the fraction of individuals that migrate from the source to the sink population (here 100%)
#7      5) the new size (relative) of the sink population (here no change in size, hence the relative new size is 1)
#7      6) the new growth rate (0)
#7      7) the new migration matrix to be used (remains at 0)
#7 
#7 - Simulate some data and plot the trees. How do they look like if the divergence time is very old? Can you distinguish them from the trees of the migration model?
#7 
#7 - Estimate FST using arlsumstat for one simulation. Does the FST match the expectation?
#7 


LOC=$(which ./ex1.sh)

PATTERN=#$1[[:blank:]]
grep "$PATTERN" $LOC | awk -F"[ ]" 'BEGIN{OFS=" "}{$1=""; print $0}'
