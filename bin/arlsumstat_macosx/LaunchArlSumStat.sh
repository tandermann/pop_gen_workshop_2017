#!/bin/bash

#Laurent Excoffier April 2015
#
#The script will compute summary statistics on all arlequin project files in turn
#It assumes that it is launched in a directory containing:
#         - a series of *.arp files to be analysed
#         - a file arl_run.ars, containing the settings specifying which 
#           computations are to be performed (usually obtained through the WinArl35.exe
#           graphical interface).

#Modify the following line to state which version of arlsumstat you are using
arlsumstat=arlsumstat64.exe #Windows version
#Modify the follwing name to specify the name of the output file for the summary statistics 
outss=outSumStats.txt

#Iterate over all project files
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
  	if [ $counter -eq 1 ]; 	then 
		#Reset file list
		(echo "$counter $file") > $fileList
		echo "Processing file $file" 
		#Compute stats, reset output file and include header
		./$arlsumstat  ./$file $outss 0 1 run_silent		
	else
		#Append file list
		(echo "$counter $file") >> $fileList
		echo "Processing file $file"
		#Compute stats and just append stats in output file assuming that all project files are of the same type
		#and will output the same statistics
		./$arlsumstat ./$file $outss 1 0 run_silent
	fi
	#Remove result directory created by arlsumstat
	rm ${file%.*}.res -r
	let counter=counter+1
done

