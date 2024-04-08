#!/bin/bash

# LSF job submission: 1 core, 30 min runtime, 16GB memory, 1 shared GPU with MPS on the new_gpu queue
#BSUB -n 1                          # Core count
#BSUB -J test_gpu                   # Job name
#BSUB -W 30                         # Runtime (minutes)
#BSUB -R "rusage[mem=16GB]"         # Memory request
#BSUB -q gpu                        # Queue selection
#BSUB -gpu "num=1:mode=shared:mps=yes" # GPU request
#BSUB -o out.%J                     # Output file
#BSUB -e err.%J                     # Error file                  

# Source the bash profile to ensure conda and other environment variables are available
source .bashrc

# Activate the Conda environment
conda activate /usr/local/usrapps/probioticengring/tvnguyen/conda/envs/tvnEnv0003_colabfold

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
