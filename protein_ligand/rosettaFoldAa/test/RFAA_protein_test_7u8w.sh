#!/bin/bash

# Job submission script for a GPU-accelerated task

# Job name
#BSUB -J rfaa_test

# Number of cores per task
#BSUB -n 4

# Ensure the job runs on a single host
#BSUB -R "span[hosts=1]"

# Wall clock limit (HH:MM)
#BSUB -W 10:00

# Memory requirements
#BSUB -R "rusage[mem=64GB]"

# Queue assignment (use GPU queue)
#BSUB -R "select[p100 || a30]"
#BSUB -q gpu

# GPU allocation: request 1 shared GPU without MPS (multi-process service)
#BSUB -gpu "num=1:mode=shared:mps=no"

# Standard output and error files
#BSUB -o out.%J
#BSUB -e err.%J

# Activate the conda environment
export HOME=/share/probioticengring/tvnguye4/
export PATH="/usr/local/usrapps/probioticengring/tvnguyen/conda/envs/tvnBase/envs/RFAA/bin:$PATH"

# Load necessary modules
module load cuda/12.0 gcc/13.2.0 compiler/latest

# Add the rf2aa module directory to the PYTHONPATH
export PYTHONPATH=$PYTHONPATH:/share/probioticengring/tvnguye4/git/RoseTTAFold-All-Atom

# Check the current Python path and environment
which python
echo $PYTHONPATH

# Check NVIDIA GPU presence, display GPU status, and verify CUDA compiler version
lspci | grep -i nvidia
nvidia-smi
nvcc --version
echo $CUDA_HOME

cd /share/probioticengring/tvnguye4/git/RoseTTAFold-All-Atom

chmod u+x /share/probioticengring/tvnguye4/git/RoseTTAFold-All-Atom/input_prep/make_ss.sh

# Execute the run_inference module from the rf2aa package
python -m rf2aa.run_inference --config-name protein
