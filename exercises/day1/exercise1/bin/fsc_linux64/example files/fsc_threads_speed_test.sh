#!/bin/bash

#Laurent Excoffier July 2014
#
# This script will launch several simulations with fsc25 and recording computation times
# for combinations of number of threads and batches.

fsc=fsc25.exe

#Number of batches
batchOptions=-B12

#---------------------------------------------
# 10 simulations of 100,000 segments of 100 bp
#---------------------------------------------

coreOptions=-c1
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" > threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt

coreOptions=-c2
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" >> threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt

coreOptions=-c3
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" >> threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt

coreOptions=-c4
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" >> threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt

coreOptions=-c5
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" >> threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt

coreOptions=-c6
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" >> threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt

coreOptions=-c7
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" >> threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt

coreOptions=-c8
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" >> threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt

coreOptions=-c9
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" >> threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt

coreOptions=-c10
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" >> threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt

coreOptions=-c11
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" >> threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt

coreOptions=-c12
echo "1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions)" >> threadsSpeedTest.txt
echo "testing 1PopDNAnoRec10Mb.par  ($coreOptions and $batchOptions)"
( time ./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions ) 2>>threadsSpeedTest.txt



#----------------------------------------------------------
# Estimation of parameter of a simple population bottleneck 
#----------------------------------------------------------

#Number of batches
batchOptions=-B12

numSims=200000
numCycles=5

coreOptions=-c1
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" > threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..

coreOptions=-c2
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" >> threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..

coreOptions=-c3
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" >> threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..

coreOptions=-c4
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" >> threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..

coreOptions=-c5
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" >> threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..

coreOptions=-c6
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" >> threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..

coreOptions=-c7
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" >> threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..

coreOptions=-c8
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" >> threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..

coreOptions=-c9
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" >> threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..

coreOptions=-c10
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" >> threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..

coreOptions=-c11
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" >> threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..

coreOptions=-c12
echo "-t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions" >> threadsSpeedTestEst.txt
echo "testing 1PopExpInst20Mb   ($coreOptions and $batchOptions)"
cd 1PopExpInst20Mb
( time ../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions ) 2>>../threadsSpeedTestEst.txt
cd ..
