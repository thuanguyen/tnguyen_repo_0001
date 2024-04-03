#!/bin/bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --nodes=1
#SBATCH --mail-user=tvnguye4@ncsu.edu
#SBATCH --mail-type=END

export HOME=/home6/tvnguye4/

# Source bashrc to ensure Conda and other environment configurations are loaded
source /home6/tvnguye4/.bashrc

# Activate Conda environment
source /home6/tvnguye4/miniconda3/etc/profile.d/conda.sh
conda activate tvnEnv0003_colabfold

# Check if Conda environment is activated
if [[ "$CONDA_DEFAULT_ENV" != "tvnEnv0003_colabfold" ]]; then
    echo "Error: Conda environment 'tvnEnv0003_colabfold' not activated."
    exit 1
fi

# Search for CUDA installation
cuda_location=$(which nvcc 2>/dev/null)

if [ -n "$cuda_location" ]; then
    cuda_dir=$(dirname $(dirname "$cuda_location"))
    export PATH="$cuda_dir/bin:$PATH"
    export LD_LIBRARY_PATH="$cuda_dir/lib64:$LD_LIBRARY_PATH"
    echo "CUDA found at: $cuda_dir"
else
    echo "Error: CUDA not found. Please ensure CUDA is installed and configured properly."
    exit 1
fi

# Execute Jupyter notebook
jupyter nbconvert --to notebook --execute --inplace /home6/tvnguye4/google_cloud/protein_ligand/colabfold/test/test2.ipynb
