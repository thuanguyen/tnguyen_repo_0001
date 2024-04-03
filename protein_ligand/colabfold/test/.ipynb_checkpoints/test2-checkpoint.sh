#!/bin/bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --nodes=1
#SBATCH --mail-user=tvnguye4@ncsu.edu
#SBATCH --mail-type=END

export HOME=/home6/tvnguye4/

# Source bashrc to ensure Conda and other environment configurations are loaded
source /home6/tvnguye4/.bashrc

# Load the CUDA module
module load cuda11/11.8

# Activate Conda environment
source /home6/tvnguye4/miniconda3/etc/profile.d/conda.sh
conda activate tvnEnv0003_colabfold

# Check if Conda environment is activated
if [[ "$CONDA_DEFAULT_ENV" != "tvnEnv0003_colabfold" ]]; then
    echo "Error: Conda environment 'tvnEnv0003_colabfold' not activated."
    exit 1
fi

# Since CUDA module is loaded, explicitly setting CUDA paths might not be necessary,
# but doing so can ensure consistency if multiple CUDA versions are present.
cuda_location=$(which nvcc)
if [ -n "$cuda_location" ]; then
    cuda_dir=$(dirname $(dirname "$cuda_location"))
    export PATH="$cuda_dir/bin:$PATH"
    export LD_LIBRARY_PATH="$cuda_dir/lib64:$LD_LIBRARY_PATH"
    echo "CUDA configured with directory: $cuda_dir"
else
    echo "Warning: CUDA not found via nvcc. Proceeding with module-loaded CUDA."
fi

# Ensure the GPU can be accessed by Python libraries such as TensorFlow or PyTorch
python -c "import torch; print('CUDA available:', torch.cuda.is_available())"

# Execute Jupyter notebook
jupyter nbconvert --to notebook --execute --inplace /home6/tvnguye4/google_cloud/protein_ligand/colabfold/test/test2.ipynb
