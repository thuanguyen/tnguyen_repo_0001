#!/bin/bash

# LSF job submission: 1 core, 30 min runtime, 16GB memory, 1 shared GPU with MPS off on the gpu queue
#BSUB -n 8
#BSUB -R span[hosts=1]
#BSUB -W 30
#BSUB -q gpu
#BSUB -gpu "num=1:mode=shared:mps=no"
#BSUB -o out.%J
#BSUB -e err.%J

# Source the bash profile to ensure conda and other environment variables are available
export HOME=/share/probioticengring/tvnguye4/
export PATH="/usr/local/usrapps/probioticengring/tvnguyen/localcolabfold/colabfold-conda/bin:$PATH"
source /share/probioticengring/tvnguye4/.bashrc

# Set CUDA 12.0 as the CUDA environment
module load cuda/12.0
module load gcc/9.3.0
module load compiler/latest

lspci | grep -i nvidia
nvidia-smi
nvcc --version
echo $CUDA_HOME

# Define input and output directories
input="/share/probioticengring/tvnguye4/google_cloud/protein_ligand/colabfold/test/input"
outputdir="/share/probioticengring/tvnguye4/google_cloud/protein_ligand/colabfold/test/outputdir"

# Run ColabFold batch prediction
CUDA_VISIBLE_DEVICES=0 colabfold_batch "$input" "$outputdir/"

# Note: There is no need to deactivate Conda environment in a script, as the environment is only active for the duration of the script.
