#!/bin/bash

###### This script create Infomap-compatible ftree files to modularize the oligomer networks
###### For more information about the Infomap method, please visit https://www.mapequation.org/infomap/

###### Cut two first columns from several *.graph files and print the output to different *.txt files

for i in *.graph
do
    cut -d" " -f1,2 $i > cut${i%.graph}.txt
done

###### Run Infomap on cut*.txt files and create ftree files in the "InfomapResults" repository
###### For more information about the parameters, please visit https://www.mapequation.org/infomap/
for i in cut*.txt
do
    infomap cutexample.txt ./InfomapResults/ -2 -N 10 --ftree > mod_cutexample.log
done
