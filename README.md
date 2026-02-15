#

## Dependencies
**conda**

Used by vipe.

**git lfs**

Used for storing data files.

installation:
```
apt update
apt install git-lfs
```

**cuda**

VIPE needs CUDA version 12.8.

To change CUDA version use:
```
sudo update-alternatives --display cuda

sudo update-alternatives --config cuda
```

## Usage

### Setup (only first time)

Update subrepositories and data files
```
make pull
```

create virtual environment and install dependencies
```
make py-install
```

install vipe
```
make vipe-install
```

### Running
activate virtual environment (if not already active)
```
source .venv/bin/activate
```

preprocess images in data directory into a mp4 file
```
./1_data_preprocessing.py
```

run vipe
```
vipe infer input.mp4
```