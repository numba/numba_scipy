#!/bin/bash

set -v -e

# first configure conda to have more tolerance of network problems, these
# numbers are not scientifically chosen, just merely larger than defaults
conda config --write-default
conda config --set remote_connect_timeout_secs 30.15
conda config --set remote_max_retries 10
conda config --set remote_read_timeout_secs 120.2
if [[ $(uname) == Linux ]]; then
    if [[ "$CONDA_SUBDIR" != "linux-32" && "$BITS32" != "yes" ]] ; then
        conda config --set restore_free_channel true
    fi
fi
conda info
conda config --show

CONDA_INSTALL="conda install -q -y"
PIP_INSTALL="pip install -q"

# Deactivate any environment
source deactivate
# Display root environment (for debugging)
conda list

# Create a base env
conda create -n $CONDA_ENV -q -y python=$PYTHON numpy=$NUMPY scipy=$SCIPY pip

# Activate
set +v
source activate $CONDA_ENV
set -v

$CONDA_INSTALL numba pytest

# environment dump for debug
echo "-------------------------------------------------------------------------"
conda env export
echo "-------------------------------------------------------------------------"
