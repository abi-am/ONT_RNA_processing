#!/bin/bash
path=$1
cd $path
for file in `ls $path | grep "directcDNA"`
do
        SAMPLE=`ls $file`
        echo $SAMPLE
##      fastqc -t 5 $file/$SAMPLE -o /data/home/arpine_grigoryan/directcDNA
done
