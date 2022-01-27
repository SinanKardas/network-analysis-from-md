#!/bin/bash

###### This script uses RedMD software to create the network files from PDB files issued from Molecular Dynamics simulations
###### It considers only the heavy atoms of the structures in the PDB files (remove 'H' and 'LP' coordinates in line 13)
###### in line 15, we choose the distance cutoff below which two nodes are connected with the following argument "--cutoffCC=3.5" (here the distance cutoff is set to 3.5 Angstroms)

module load RedMD/2.3

####  PDB to SXML 
for pdb in ./*.pdb
do
   filename=$(basename "$pdb" .pdb)
   cat $pdb |  grep -v '  H' | grep -v '  LP' | sed 's/./ /13' | sed 's/./C/14' | sed 's/./A/15' | sed 's/./ /16' > $filename.pxml 
   RedMD_extractPDB $filename.pxml > $filename.txml
   GenForceField --type=ENM --cutoffCC=3.5 $filename.txml > $filename.sxml   
done 
rm *.pxml


####  SXML to graph files 
for sxml in ./*.sxml
do
   filename=$(basename "$sxml" .sxml)
   cat $sxml |  grep 'BOND'  > $filename.tmp
   sed -i 's/    <BOND idAtom1="X:CA://g' $filename.tmp
   sed -i 's/" idAtom2="X:CA:/ /g' $filename.tmp
   sed -i 's/" k="1.000000" l0="/ /g' $filename.tmp
   sed 's/.\{3\}$//' $filename.tmp > $filename.graph 
   sed -i -e "1d" $filename.graph
done 
rm *.sxml
rm *.tmp
