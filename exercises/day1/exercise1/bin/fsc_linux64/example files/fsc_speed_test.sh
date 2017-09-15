#!/bin/bash

#Laurent Excoffier July 2014
#
# This script will launch several simulations with fastsimcoal21 (Dec 2013) and/or fsc25 (July 2014)


fsc=fsc22.exe
fsc=fastsimcoal21.exe

coreOptions=-c0
batchOptions=-B8

echo "testing 1PopDNAnoRec10Mb.par"
./$fsc -i 1PopDNAnoRec10Mb.par -n10 -I -x --seed 1234 -q $coreOptions $batchOptions
echo "testing 1PopDNAnoRec100Mb.par"
./$fsc -i 1PopDNAnoRec100Mb.par -n10  -I -x --seed 1234 -q $coreOptions $batchOptions
echo "testing 1PopDNArec10Mb.par"
./$fsc -i 1PopDNArec10Mb.par -n10  -I -x --seed 1234 -q $coreOptions $batchOptions
echo "testing 1PopDNArec100Mb.par"
./$fsc -i 1PopDNArec100Mb.par -n1 -I -x --seed 1234 -q $coreOptions $batchOptions

numSims=100000
numCycles=5


echo "testing 1PopExpInst20Mb"
cd 1PopExpInst20Mb
../$fsc -t 1PopExpInst20Mb.tpl -e 1PopExpInst20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions
cd ..

echo "testing 2PopDiv20Mb"
cd 2PopDiv20Mb
../$fsc -t 2PopDiv20Mb.tpl -e 2PopDiv20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions
cd ..

echo "testing 2PopDivMigr20Mb"
cd 2PopDivMigr20Mb
../$fsc -t 2PopDivMigr20Mb.tpl -e 2PopDivMigr20Mb.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 2 -q $coreOptions $batchOptions

cd ..
numSims=10000

echo "testing 3PopExpBotm"
cd 3PopExpBotm
../$fsc -t 3PopExpBotm.tpl -e 3PopExpBotm.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 2 -q $coreOptions $batchOptions
cd ..

echo "testing 3PopExpBotm with --multiSFS"
cd 3PopExpBotm
../$fsc -t 3PopExpBotm.tpl -e 3PopExpBotm.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 --multiSFS -q $coreOptions $batchOptions
cd ..

numSims=1000

echo "testing 10Pop2ContiIsl"
cd 10Pop2ContiIsl
../$fsc -t 10Pop2ContiIsl.tpl -e 10Pop2ContiIsl.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 1234 -q $coreOptions $batchOptions
cd ..

echo "testing 10Pop2ContiIsl"
cd 10Pop2ContiIsl
../$fsc -t 10Pop2ContiIsl.tpl -e 10Pop2ContiIsl.est -d -M0.001 -n$numSims -N$numSims-I -l$numCycles -L$numCycles --seed 12345 -q $coreOptions $batchOptions
cd ..
