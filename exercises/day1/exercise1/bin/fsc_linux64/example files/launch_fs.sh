#!/bin/bash

#Laurent Excoffier December 2010
#
# The script will launch several instances of fastsimcoal 

#Creating a shortcut for fastsimcoal
fs=fsc25

if [ $# -ne 4 ]; then
   echo "Expecting the following values on the command line, in that order"
   echo "   Number of instances to run"
   echo "   Generic name of template file"
   echo "   Number of random parameter to draw"
   echo "   Number of simulations per sets of parameter values"
else
   #Using values from the command line
   numInstances=$1
   genericName=$2
   numEstimates=$3
   numSimsPerEst=$4   
   echo "numInstances=$numInstances"
   echo "genericName=$genericName"
   echo "numEstimates=$numEstimates"
   echo "numSimsPerEst=$numSimsPerEst"   
fi

#Directory for job console outputs
msgs=consoleOutputs
mkdir $msgs 2>/dev/null

echo "Launching ${numInstances} instances of $fs"
let COUNT=numInstances 
instancesLaunched=0 
while [ $COUNT -gt 0 ]; do
   curInst=fs_job${COUNT}.sh  
   newDir=${genericName}_res${COUNT}
   mkdir ${newDir} 2>/dev/null
   cp ./$fs ${newDir}/.
   cp ./${genericName}.est ${newDir}/.
   cp ./${genericName}.tpl ${newDir}/.
   cp ./$fs  ${newDir}/.
   cd  ${newDir}      
   let instancesLaunched=instancesLaunched+1
   if [ -e ./$fs ] ; then
      (
      echo "#!/bin/bash"
      echo "#$ -cwd"
      echo "# specify resources needed"
      echo "#$ -l h_cpu=48:00:00"
      echo "#$ -N fs${COUNT}_run"
      echo "#$ -o ../$msgs/fs${COUNT}.out"
      echo "#$ -e ../$msgs/fs${COUNT}.err"
      echo "#$ -m a"
      echo "#$ -q all.q"
      echo ""
      echo "chmod +x ./$fs"
      echo "./$fs -t ${genericName}.tpl -n ${numSimsPerEst} -e  ${genericName}.est -E ${numEstimates} -q"
      echo "rm ./$fs"
		) > $curInst
      chmod +x $curInst
		qsub ${curInst}
   else
      echo "File $fs not found. Aborting instance $instancesLaunched"
   fi  
   cd ..   
   let COUNT=COUNT-1
done
