#!/bin/bash
path=$1
cd $path
for file in `ls $path | grep "directcDNA"`
do
        SAMPLE=`ls $file`
        fastqc -t 5 $file/$SAMPLE -o /data/home/arpine_grigoryan/directcDNA
done
