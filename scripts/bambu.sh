#!/bin/bash
#SBATCH--mem=60gb
#SBATCH--output=slurm-%j.log
#SBATCH--thread-spec=10

Rscript bambu.R
