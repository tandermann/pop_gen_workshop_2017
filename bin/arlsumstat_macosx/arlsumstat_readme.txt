                          ARLSUMSTAT (v.3.5.2)
                          ==========
                          
ARLSUMSTAT is a modified version of Arlequin for computing summary statistics
listed in the file named "ssdefs.txt", and reporting them in an output file

Usage:
------
  arlsumstat <project file name> <sum. stat. output file>
             <[int] append output file> <[int] write header>
             | RUN_SILENT

  The parameter <project file name> needs to be put within quotes if 
  it contains whitepaces 

  The parameter <[int] write header> controls if a header with 
  the names of the sum. stats. needs to be written
    Possible values:
      0: no, only computed summary statistics will be output
      1: yes, header and statistics will be output
      2, yes, only header will be output, but no summary stats
    Default value is 0.

  RUN_SILENT: if present on the command line, arlsumstat will not output
              computation progress in the console



What is needed to run arlsumstat:
--------------------------------
- arlsumstat executable file under windows or linux
- settings file "arl_run.ars" created with the windows version of arlequin (see below)
- ssdefs.txt file specifying which statistics are output in a result file (see below)



Different flavors of arlsumstat:
--------------------------------
We provide these different versions of arlsumstat:
- arlsumstat64.exe    : 64 bit windows executable
- arlsumstat32.exe    : 32 bit windows executable
- arlsumstat_64bit    : 64 bit linux version
- arlsumstatmac_64bit : 64 bit MacOS version


How to set up the setting file arl_run.ars:
-------------------------------------------
- Launch the Windows version or Arlequin
- Open a project file of the type you want to analyse
- Choose the computations you want to perform
- Close the project
- A new file arl_run.ars will have been created that contains all the necessary information
  about which computations to perform and which parameters to use for those computations.
- Copy this file in the directory of the arlsumstat executable file
- The same arl_run.ars file can be used under both windows and linux.



ssdefs.txt file
---------------
You can write  a series of keywords (on separate lines) in the file "ssdefs.txt".
These keywords specify which statistics will be written in the output file.
Note that it is the settings file "arl_run.ars" that specifies which statistics will 
be actually computed by arlsumstat. Keywords in ssdefs.txt thus only specifies if the 
computed statistics are listed in the output file.
Therefore, you should make sure that the setting file "arl_run.ars" is correctly set up.
ssdefs.txt needs to be present in the same directory as the executable arlsumstat file.



Keywords in ssdefs.txt
----------------------
POP_LEVEL         //Computation of all statistics at the population level
GROUP_LEVEL       //Computation of all statistics at the group level, with group
                  //definition taken from the genetic structure defined in the project
ALL_K             //Mean number of alleles over loci output for each population  
ALLSD_K           //s.d. over loci of the number of allele for each population
MEAN_K            //Mean number of alleles over loci and population
SD_K              //s.d. over populations of the mean number of alleles 
TOT_K             //Mean total number of alleles over loci: 
                  //For haplotypic data: total number of haplotypes. 
                  //Need to activate "Infer from distance matrix" in Haplotypic definition box. 
ALL_H             //Mean heterozygosity over loci output for each population
ALLSD_H           //s.d. over loci of the heterozygosity for each population
MEAN_H            //Mean heterozygosity over loci and population
SD_H              //s.d. of the mean hetrozygosity over populations
TOT_H             //Mean total heterozygosity
ALL_S             //Number of sites with segregating substitutions output for each population
PRIVATE_S         //Number of private polymorphic sites per population
MEAN_S            //Mean number of sites with segregating substitutions over population
SD_S              //s.d. of the number of sites with segregating substitutions over population
TOT_S             //Total number of polymorphic sites over all populations 
ALL_TAJIMAD       //Tajima's D reported for each population
MEAN_TAJIMAD      //Mean Tajima's D over all populations
SD_TAJIMAD        //s.d. Tajima's D over all populations
ALL_FUFS          //Fu's Fs for each pop
MEAN_FUFS         //Mean FS over all pops
SD_FUFS           //s.d. FS over all pops
ALL_PI            //Mean number of pairwise differences for each pop
MEAN_PI           //Mean number of pairwise differences over pops
SD_PI             //s.d. of the mean number of pairwise differences over pops
PAIRWISE_PI       //Mean number of differences between pairs of populations
PAIRWISE_DMUSQR   //Mean delta mu-square (square difference in mean STR allele length between 
                  //pairs of populations) over loci
ALL_GW            //Mean Garza-Williamson statistic over loci for each pop 
ALLSD_GW          //s.d. over loci of the Garza-Williamson index for each population
MEAN_GW           //Mean Garza-Williamson statistic over loci and pops
SD_GW             //s.d. over pops of the mean Garza-Williamson statistic 
TOT_GW            //Mean Garza-Williamson index computed over a poll of all populations 
                  //(simply mean TOT_Ki/(TOT_RANGEi+1)
ALL_NGW           //Mean over loci of the modified Garza-Williamson index for each population            
ALLSD_NGW         //s.d. over loci of the modified Garza-Williamson index for each population
MEAN_NGW          //Mean over loci and populations of the modified Garza-Williamson index      
SD_NGW            //s.d. over populations of the mean modified Garza-Williamson index      
ALL_RANGE         //Mean allelic range over loci for each pop
ALLSD_RANGE       //s.d. over loci of allelic range for each population         
MEAN_RANGE        //Mean allelic range over loci and pops
SD_RANGE          //s.d. over pops of the mean allelic range
TOT_RANGE         //Mean total allelic range over loci and pops
GLOBAL_FSTAT      //Global F-statistics specified in the settings file 
                  //(could be FIS, FST, FCT, FST, and/or FSC)
PAIRWISE_FST      //Computes all pairwise FST

Note that one of the two flags POP_LEVEL or GROUP_LEVEL need to be defined,
otherwise nothing will be computed
With group level activated, population samples belonging ot a given group are 
pooled into a single population samples, and statistics are computed on 
this pooled sample.
This can be quite useful, and could allow for instance to compute pairwise 
FSTs between groups (a bit like pairwise FCT)s

Activation of specific computations to compute desired summary statistics
-------------------------------------------------------------------------

The inclusion of specific keywords in ssdefs.txt will not automatically activate the computation of 
the desired statistics, and specific computations need to be activated in WinArl35 interface,and the
resulting settings file called "arl_run.ars" needs to be saved in the same directory as the
arlsumstat program.
We list below the summary statistics computed by the activation of specific settings. 

Settings tab Molecular diversity indices: 
    Check "Standard diversity indices" to compute 
           ALL_K, ALLSD_K, MEAN_K, SD_K, TOT_K, ALL_H, ALLSD_H, MEAN_H, SD_H, TOT_H
           ALL_GW, ALLSD_GW, MEAN_GW, SD_GW, TOT_GW, ALL_NGW, ALLSD_NGW, MEAN_NGW, 
           SD_NGW, ALL_RANGE, ALLSD_RANGE, MEAN_RANGE, SD_RANGE, TOT_RANGE

    Check "Molecular indices" to compute: 
           ALL_S, PRIVATE_S, MEAN_S, SD_S, TOT_S, ALL_PI, MEAN_PI, SD_PI,

Settings tab Neutrality tests: 
    Check "Tajima's D" to compute 
           ALL_TAJIMAD, MEAN_TAJIMAD, SD_TAJIMAD
    Check "Fu's Fs" to compute:
           ALL_FUFS, MEAN_FUFS, SD_FUFS,

Settings tab AMOVA: 
    Check "Standard AMOVA" or "Locus by locus AMOVA" to compute 
           GLOBAL_FSTAT (this will compute FST, FSC and FCT, if you have a hierarchical genetic structure,
                         and simply FST otherwise)
           Further check "Include individual level" if you want to compute FIS and FIT

Settings tab Population comparisons: 
    Check "Compute pairwise FST" to compute 
           PAIRWISE_FST
    Check "Compute pairwise (delta-mu)^2" to compute (MICROSAT data only)
           PAIRWISE_DMUSQR
    Check "Compute pairwise differences" to compute 
           PAIRWISE_PI
           

Bash script to launch arlsumstat
--------------------------------
We provide with arlsumstat a basic bash script called LaunchArlSumStat.sh, 
allowing one to compute the same summary statistics on all the files present in a given directory.
It assumes that this directory also contains arlsumstat, as well as the files arl_run.ars and ssdefs.txt.
This bash script will run on Linux by just typing the command
  ./LaunchArlSumStat.sh
and on windows by typing the command
  bash LaunchArlSumStat.sh
assuming you have installed the cygwin package (available on http://www.cygwin.com/), and that the 
cygwin/bin directory is on your path environment variable.
Note that you'll need to edit LaunchArlSumStat.sh (with any text editor - not Word) to specify:
- the version of arlsumstat you are using
- the name of the output file where summary statistics will be written
You can also specify the name of a file containing all the arlequin projects that have been 
analysed by arlsumstat. The default name is "arlProjectsList.txt". This is useful to know the exact project
on which a set of summary statistics has been computed.



Bash script LaunchArlSumStat.sh
-------------------------------
   #!/bin/bash
   #Laurent Excoffier October 2009
   #
   #The script will compute summary statistics on all arlequin project files in turn
   #This script creates the files necessary to launch arlequin computations
   #and launches arlsumstat
   #It assumes that it is launched in a directory containing:
   #         - a series of *.arp files to be analysed
   #         - a file arl_run.ars, containing the settings specifying which 
   #           computations are to be performed (usually obtained through the WinArl35.exe
   #           graphical interface).

   #Modify the following line to state which version of arlsumstat you are using (here windows)
   arlsumstat=arlsumstat.exe 
   #Modify the follwing name to specify the name of the output file for the summary statistics 
   outss=outSumStats.txt


   #Iterate over all project files
   #You can modify this name as you want 
   fileList='arlProjectsList.txt'
   
   #Change the following line if you want to use another settings file  for the computations
   settingsFile=arl_run.ars
   if [ "$settingsFile" != "arl_run.ars" ]; then 
      if [ -f $settingsFile ]; then
         echo "copying file $settingsFile to arl_run.ars"
         cp $settingsFile arl_run.ars
      else 
         echo "file $settingsFile does not exist, cannot copy it to arl_run.ars"   
         echo "using existing arl_run.ars file for computations"
      fi
   fi

   counter=1;
   for file in *.arp
   do
      if [ $counter -eq 1 ];           then 
         #Reset file list
         (echo "$counter $file") > $fileList
         echo "Processing file $file"
         #Compute stats, reset output file and include header
         ./$arlsumstat  ./$file $outss 0 1 run_silent                              
      else
         #Append file list
         (echo "$counter $file") >> $fileList
         echo "Processing file $file"
         #Compute stats and just append stats in output file 
         #assuming that all project files are of the same type
         #and will output the same statistics
         ./$arlsumstat ./$file $outss 1 0 run_silent          
      fi
      #Remove result directory created by arlsumstat
      rm ${file%.*}.res -r
      let counter=counter+1
   done



Running a single instance of arlsumstat on the command line
-----------------------------------------------------------

Examples under Linux:

The following command will analyse the file test.arp and write the summary 
statistics in the file outSS.txt, which will be reset, and which will begin 
with a header line with the names of the summary statistics:
  ./arlsumstat_64bit test.arp outSS.txt 0 1
  
If you want to append summary statistics computed on the file test1.arp 
to the same output file outSS.txt, without writing a header line, just type:
  ./arlsumstat_64bit test1.arp outSS.txt 1 0

The following command will append your summary stats to the same file but 
this time including a header line, with the names of the summary stats:
  ./arlsumstat_64bit test2.arp outSS.txt 1 1
  
  
Example of a simple bash script to analyse arlequin files generated with simcoal3
-------------------------------------------------------------------------------
   
   #!/bin/bash
   #Name of the simcoal parameter file
   parameterFile=1Pop_n20_10STR.par
   #Name of the files containing computed summary statistics
   outss=outss.txt
   #generate 1000 files with 20 diploid individuals analysed at 10 STR loci
   ./simcoal3 $parameterFile 100 1
   #Move to directory containing arlequin files generated by simcoal2
   cd ${parameterFile%.*}
   cp ../arlsumstat.exe .
   cp ../arl_run.ars .
   cp ../ssdefs.txt .
   counter=1;
   for file in *.arp
   do
      echo "Processing file $file"
      if [ $counter -eq 1 ];  then 
         #Compute stats, reset output file "outss.txt" and include header
         ./arlsumstat  ./$file $outss 0 1 run_silent                              
      else
         #Compute stats and just append stats in output file "outss.txt"
         ./arlsumstat ./$file $outss 1 0 run_silent          
      fi
      let counter=counter+1
   done
   #Remove result directory created by arlsumstat
   rm *.res -r
   mv $outss ..
   cd ..
   
   Output in file outss.txt
   ------------------------
   
   K_1      H_1          GW_1          R_1          FIS
   9.3      0.843974     0.831385      10.5         0.07813
   10.3     0.878718     0.913119      10.6        -0.0268655
   8.9      0.853077     0.882307      9.3          0.0654754
   9.4      0.860897     0.87426       10.3         0.106819


-----
Laurent Excoffier, December 2009
Email: laurent.excoffier@iee.unibe.ch








