//Parameters for the coalescence simulation program : fastsimcoal.exe
3 samples to simulate :
//Population effective sizes (number of genes)
NPOPAF
2000000
2000000
//Samples sizes and samples age 
20
20
20
//Growth rates	: negative growth implies population expansion
0
R1
R1
//Number of migration matrices : 0 implies no migration between demes
2
//Migration matrix 0
0.0000 0.0000 0.0000
0.0000 0.0000 MIG
0.0000 MIG 0.0000
//Migration matrix 1
0 0 0
0 0 0
0 0 0
//historical event: time, source, sink, migrants, new deme size, new growth rate, migration matrix index
8 historical event
TDIV 2 0 1 1 0 1
TDIV 1 0 1 1 0 1
TDIV 1 1 0 1 0 1   //Set growth rate to 0 in deme 1
TDIV 2 2 0 1 0 1   //Set growth rate to 0 in deme 2 
TBOT 0 0 0 RES1 0 1
TENDBOT 0 0 0 RES2 0 1
TENDBOT 1 1 0 1 0 1
TENDBOT 2 2 0 1 0 1
//Number of independent loci [chromosome] 
1 0
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per generation recombination and mutation rates and optional parameters
FREQ 1 0 2.5e-8 OUTEXP