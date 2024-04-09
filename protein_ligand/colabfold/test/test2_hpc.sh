#!/bin/bash

# LSF job submission: 8 cores, 30 min runtime, 32GB memory, 1 shared GPU with MPS on the gpu queue
#BSUB -n 8                          # Core count
#BSUB -J test_gpu                   # Job name
#BSUB -W 30                         # Runtime (minutes)
#BSUB -R "rusage[mem=32GB]"         # Memory request
#BSUB -q gpu                        # Queue selection
#BSUB -gpu "num=1:mode=shared:mps=no" # GPU request, requesting 1 GPU in shared mode with MPS enabled
#BSUB -o out.%J                     # Output file
#BSUB -e err.%J                     # Error file                  

# Source the bash profile to ensure conda and other environment variables are available
export HOME=/share/probioticengring/tvnguye4/
source /share/probioticengring/tvnguye4/.bashrc

# Activate the Conda environment
conda activate tvnEnv0003_colabfold

# Set CUDA 12.0 as the CUDA environment
export PATH=/usr/local/apps/cuda/cuda-12.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/apps/cuda/cuda-12.0/lib64:$LD_LIBRARY_PATH
export CUDA_HOME=/usr/local/apps/cuda/cuda-12.0

# Verify CUDA Compiler Version to ensure CUDA 12.0 is loaded properly
nvcc -V

# Check NVIDIA System Management Interface to confirm GPU allocation
nvidia-smi

# Execute the Jupyter notebook, converting it in place to ensure all cells are executed
jupyter nbconvert --to notebook --execute --inplace /share/probioticengring/tvnguye4/google_cloud/protein_ligand/colabfold/test/test2.ipynb

# Deactivate the Conda environment
conda deactivate
