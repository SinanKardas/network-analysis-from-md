# network-analysis-from-md

this bash script prepares the network files from a pdb files than can be used in Cytoscape software for network analyses.

in line 8, we don't take into account the H atoms (and the lone pairs (LP) if needed) to construct the network

in line 10, we choose the distance cutoff below which two nodes are connected with the following argument "--cutoffCC=3.5" (here the distance cutoff is set to 3.5 Angstroms).
