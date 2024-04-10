#!/bin/bash

#BSUB -n 2
#BSUB -J download
#BSUB -o stdout.%J
#BSUB -e stderr.%J

export HOME=/share/probioticengring/tvnguye4/

bash /share/probioticengring/tvnguye4/database/colabfold/setup_databases.sh