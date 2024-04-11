#!/bin/bash

#BSUB -J rfaa_test
#BSUB -n 4
#BSUB -R span[hosts=1]
#BSUB -W 10:00
#BSUB -R span[hosts=1]
#BSUB -R "rusage[mem=32GB]"
#BSUB -q gpu
#BSUB -gpu "num=1:mode=shared:mps=no"
#BSUB -o out.%J
#BSUB -e err.%J

# Source the bash profile to ensure conda and other environment variables are available
export HOME=/share/probioticengring/tvnguye4/
export PATH="/usr/local/usrapps/probioticengring/tvnguyen/conda/envs/tvnBase/envs/RFAA/bin:$PATH"
source /share/probioticengring/tvnguye4/.bashrc

# Set CUDA 12.0 as the CUDA environment
module load cuda/12.0
module load gcc/13.2.0
module load compiler/latest

lspci | grep -i nvidia
nvidia-smi
nvcc --version
echo $CUDA_HOME

python -m rf2aa.run_inference --config-name protein
