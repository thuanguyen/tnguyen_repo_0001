#!/bin/bash

# Job submission script for a GPU-accelerated task

# Job name
#BSUB -J rfaa_test

# Number of cores per task
#BSUB -n 6

# Wall clock limit (HH:MM)
#BSUB -W 60

# Memory and host-span requirements (combined in one line for clarity)
#BSUB -R "rusage[mem=16GB] span[hosts=1]"
# rm BSUB -m "gpu06" 

# GPU specification: request one NVIDIA A30 GPU in shared mode without MPS (Multi-Process Service)
#BSUB -q gpu
#BSUB -gpu "num=1:mode=shared:mps=no"

# Standard output and error files
#BSUB -o out.%J
#BSUB -e err.%J

# Activate the conda environment
export HOME=/share/probioticengring/tvnguye4/
export PATH="/usr/local/usrapps/probioticengring/tvnguyen/conda/envs/tvnBase/envs/RFAA/bin:$PATH"
export PYTORCH_CUDA_ALLOC_CONF="max_split_size_mb:128"

# Load necessary modules
module load cuda/11.2 gcc/13.2.0 compiler/latest

# Add the rf2aa module directory to the PYTHONPATH
export PYTHONPATH=$PYTHONPATH:/share/probioticengring/tvnguye4/git/RoseTTAFold-All-Atom

# Check the current Python path and environment
which python
echo $PYTHONPATH

#Check NVIDIA GPU presence, display GPU status, and verify CUDA compiler version
lspci | grep -i nvidia
nvidia-smi
nvcc --version
echo $CUDA_HOME

cd /share/probioticengring/tvnguye4/git/RoseTTAFold-All-Atom

chmod u+x /share/probioticengring/tvnguye4/git/RoseTTAFold-All-Atom/input_prep/make_ss.sh

# Execute the run_inference module from the rf2aa package
HYDRA_FULL_ERROR=1 python -m rf2aa.run_inference --config-name protein_na_sm
