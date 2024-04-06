#!/bin/bash

#BSUB -n 4
#BSUB -J tes_gpu
#BSUB -W 1:00
#BSUB -q gpu
#BSUB -gpu "num=1:mode=shared:mps=no"

# Load the CUDA module
module load cuda

# Execute Jupyter notebook
jupyter nbconvert --to notebook --execute --inplace /home6/tvnguye4/google_cloud/protein_ligand/colabfold/test/test2.ipynb
