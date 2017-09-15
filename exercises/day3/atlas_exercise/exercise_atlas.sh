#!/bin/bash
# 
# -----------------------------------------------------------
# Exercise 1: Analyzing ancient early farmer with ATLAS
# -----------------------------------------------------------
# Steps:
#   1) Compile the latest version of atlas
#   2) Get familiar with samtools and the BAM format
#   3) Split reads by length (task=splitRGByLength)
#   4) estimate post-mortem damage patterns (task=estimatePMD)
#   5) recalibrate base quality scores (task=recal)
#   6) plot recalibrated quality scores
#   7) estimate theta (task=estimateTheta)
#   8) plot theta estimates
# 
# To see the individual steps, type './exercise_atlas.sh STEP', where STEP is the number of the desired step.
# 

#1 
#1 Step 1: Compile the latest version of atlas
#1 --------------------------------------------
#1 - Mats, the cluster administrator, has already installed atlas, you can load it with the command:
#1 
#1 > module load Atlas/v.X.X
#1 
#1 - You can find the manual to atlas here: https://bitbucket.org/phaentu/atlas/wiki/Home . Each task of atlas has its own page in the manual.
#1 
#1 


#2 
#2 Step 2: Get familiar with the BAM format and samtools
#2 ------------------------------------------------------
#2 - We will analyze the early farmer genome Bar31, which is a female from Turkey, around 8000 years old, and sequenced single-end at a depth of about  3.7x. However, since the whole genome is several GB large I have here provided you with the alignment of chromosome 22 only.
#2 
#2 - Atlas works directly from single-sample BAM files. If you are already familiar with samtools and BAM files you can skip this step.
#2 
#2 - For the others: BAM is the binary version of the SAM (Sequence Alignment Map) format. This binary format cannot be understood by humans, it needs to be translated back to SAM for us to understand it. The translation can be done on-the-fly with the program samtools, which should already be installed on your server. For a detailed description of the SAM format, check out the manual at https://samtools.github.io/hts-specs/SAMv1.pdf . For those unfamiliar with BAM files or samtools, here are some useful commands:
#2 
#2 - Try looking at a BAM file without translating it to SAM
#2
#2 > less Bar31_chr22.bam
#2 
#2 - Now use samtools view to translate it on the fly. The -h means that you want the header section to be output as well as the alignments section. Samtools view will output the whole file line by line so you will want to kill this process after a couple of seconds, no need to read the whole file! 
#2
#2 > samtools view -h Bar31_chr22.bam
#2 
#2 - If you want to be able to scroll through the file the trick is to pipe the above command into "less" and scroll down with the space bar:
#2
#2 > samtools view -h Bar31_chr22.bam | less
#2 
#2 - For a list of all viewing options, simply type "samtools view". For example, if it is only the header section you are interested in viewing, use the -H option instead of -h
#2
#2 > samtools view -H Bar31_chr22.bam
#2 
#2 
#2 


#3 
#3 Step 3: Split reads by length
#3 ------------------------------
#3 
#3 - Since Bar31 was sequenced single-end, the reads have to be split according to length in order for us to be able to accurately infer the post-mortem damage patterns. Look at the read group names in the header section of our genome Bar31.bam:
#3 
#3 > samtools view -H Bar31_chr22.bam | grep @RG
#3 
#3 The names all contain "less99" or "plus100", meaning that the read groups have already been split according to read length! Nothing more to do here :-)
#3  
#3 
#3 

#4 
#4 Step 4: estimate post-mortem damage patterns (task=estimatePMD)
#4 ---------------------------------------------------------------
#4 
#4 - Now we can estimate the damage pattern of Bar31. This task requires the reference sequence because it counts the amount of C->T and G->A changes with respect to the reference at all positions of the reads in order to infer the patterns.
#4 
#4 > atlas task=estimatePMD bam=Bar31_chr22.bam fasta=hg19_Genome_22.fasta chr=22 verbose
#4 
#4 - Plot the patterns using the Rscript plot_pmd.R, which is taken from the atlas manual. This script takes 1 argument, which is the prefix of the PMD output files, in this case Bar31_chr22.  
#4 
#4 > Rscript plot_pmd.R Bar31
#4 
#4 - Take a look at the resulting pdf file Bar31_chr22_pmdPlot.pdf
#4 
#4 > evince Bar31_chr22_pmdPlot.pdf
#4 
#4 Which pattern do you trust more, the empiric or exponential one?
#4 
#4 
#4 --> There are pros and cons to both patterns. If there is enough data, the empiric pattern is more precise. However, if there is little data the exponential pattern will smooth over the noise.

#5 
#5 Step 5: estimate theta
#5 ----------------------------------------------------
#5 - Now that we can account for the post-mortem damage we are ready to estimate the heterozygosity along the genome! Make sure you include your PMD pattern of choice in the command (either the empiric PMD table or the exponential PMD table). If you were working with modern data you would omit the pmdTable part of the command. You can kill this process after a couple of windows. Do you recognize some of the statistics that are calculated for every window?
#5 
#5 > atlas task=estimateTheta bam=Bar31_chr22.bam chr=22 pmdFile=... verbose
#5 
#5 - I have prepared the output file for the whole genome, called Bar31_theta_estimates.txt. You can see the unfinished output from your command in Bar31_chr22_theta_estimates.txt.
#5 
#5 - You can plot the estimates with the script plot_theta.R. It takes 2 arguments, the first being the chromosome that should be plotted and all consecutive arguments are the prefixes of the theta estimate files that should be plotted.
#5 
#5 > Rscript plot_theta.R 1:22 Bar31
#5 
#5 - Take a look at the resulting plot Bar31_theta_figure.pdf. Knowing that modern humans have an expected heterozygosity of 0.001, does the heterozygosity pattern seem plausible?
#5 
#5 
#5 --> No! The quality scores have to be recalibrated! The quality scores given by the illumina machine are not accurate. The expected theta being on the same order of magnitude as a typical error rate, the quality scores have a big impact on the estimation of theta and thus need to be accurate.
#5 
#5 
#5 
#5 


#6 
#6 Step 6: recalibrate base quality scores (task=recal)
#6 ----------------------------------------------------
#6 
#6 - We will use the atlas functionality "recal" to recalibrate the base quality scores. Since Bar31 is female, we will not use the X-chromosome for non-polymorphic sites (it is not haploid in females). Insteand we will use a set of uncoding regions that are conserved across vertebrates (Dimitrieva, S. and Bucher, P. (2013)). No fasta file is required, since the recal method is reference-free! 
#6 
#6 - I chose the empiric PMD pattern because the exponential pattern is not a good fit and it seems we had enough data for it to be quite smooth (not too noisy).
#6 
#6 > atlas task=recal bam=Bar31_chr22.bam pmdFile=Bar31_chr22_PMD_input_Empiric.txt chr=22 regions=hg19_UCNE_coord_withoutChr.bed verbose
#6 
#6 This task is time and memory intensive so you can kill it after having verified it works. I have already prepared the output files based on the whole genome, named Bar31_recalibrationEM.txt
#6 
#6 
#6 

#7 
#7 Step 7: plot recalibrated quality scores
#7 -----------------------------------------
#7 
#7 - We can see how the recalibration affects the base quality scores with an Rscript taken from the atlas manual:
#7 
#7 > Rscript plot_qualityTransformation.R Bar31_total
#7 
#7 Were the original quality scores higher or lower? Were the estimated theta values without recalibration too high or too low? Does this make sense now?
#7 



#8
#8 Step 8: estimate theta again
#8 -----------------------------
#8 
#8 - Now that we have recalibrated the base quality scores we are ready to estimate the heterozygosity along the genome by taking them into account! Can you find the command in the manual? If you were working with modern data the command would not be identical except that you would not provide the post-mortem damage patterns.
#8 
#8 - This will take some time to run, so I have prepared the output file for the whole genome, called Bar31_withRecal_theta_estimates.txt
#8 
#8 


#9 
#9 Step 9: plot theta estimates
#9 -----------------------------
#9 - You can plot the new theta estimates with the script plot_theta.R
#9
#9 > Rscript plot_theta.R 1:22 Bar31_withRecal
#9
#9 - Take a look at the plot that was produced, Bar31_with_recalibration_theta_figure.pdf. What do you think could be causing the increased theta estimates around 120 Mbp in chromosome 1 ?
#9 
#9 
#9 




LOC=$(which ./exercise_atlas.sh)

PATTERN=#$1[[:blank:]]
grep "$PATTERN" $LOC | awk '{$1=""; print $0}'
