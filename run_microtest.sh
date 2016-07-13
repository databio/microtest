#!/bin/bash
#SBATCH --job-name='{JOBNAME}'
#SBATCH --output='{LOGFILE}'
#SBATCH --mem='{MEM}'
#SBATCH --cpus-per-task='{CORES}'
#SBATCH --time='{TIME}'
#SBATCH --partition='{PARTITION}'
#SBATCH -m block
#SBATCH --ntasks=1

echo 'Compute node:' `hostname`
echo 'Start time:' `date +'%Y-%m-%d %T'`

# Setup virtual environment to work
virtualenv microtestenv

cd microtestenv

# "Source" to activate the environment
# this is equivalent to the "source" command
# but that cannot be executed inside a job/process or
# would spawn another shell
. ./bin/activate  

# install the stack
pip install https://github.com/epigen/looper/zipball/master
pip install https://github.com/epigen/pypiper/zipball/master

# clone pipelines
git clone https://github.com/epigen/open_pipelines

# clone microtest
git clone https://github.com/epigen/microtest

# run
looper -c microtest/config/microtest_config.yaml

echo 'End time:' `date +'%Y-%m-%d %T'`
