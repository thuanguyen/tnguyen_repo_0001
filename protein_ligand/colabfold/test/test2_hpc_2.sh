#!/bin/bash

# LSF job submission: 1 core, 30 min runtime, 16GB memory, 1 shared GPU with MPS on the new_gpu queue
#BSUB -n 1                          # Core count
#BSUB -J test_gpu                   # Job name
#BSUB -W 30                         # Runtime (minutes)
#BSUB -R "rusage[mem=16GB]"         # Memory request
#BSUB -q gpu                        # Queue selection
#BSUB -gpu "num=1:mode=shared:mps=no" # GPU request
#BSUB -o out.%J                     # Output file
#BSUB -e err.%J                     # Error file                  

# Source the bash profile to ensure conda and other environment variables are available
export HOME=/share/probioticengring/tvnguye4/
export PATH="usr/local/usrapps/probioticengring/tvnguyen/conda/envs/tvnBase/envs/tvnEnv0003_colabfold/bin:$PATH"
source /share/probioticengring/tvnguye4/.bashrc

# Set CUDA 12.0 as the CUDA environment
module load cuda/12.0
module load gcc/9.3.0
module load compiler/latest

lspci | grep -i nvidia
nvidia-smi
nvcc --version
echo $CUDA_HOME

# Execute the Jupyter notebook, converting it in place to ensure all cells are executed
jupyter nbconvert --to notebook --execute --inplace /share/probioticengring/tvnguye4/google_cloud/protein_ligand/colabfold/test/test2.ipynb
