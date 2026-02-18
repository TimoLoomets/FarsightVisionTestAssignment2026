#

## Dependencies
**git lfs**

Used for storing data files.

installation:
```
make install-git-lfs
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

apply patches to vipe:
* enables fallback for weights requesting from google drive to use local file
* reduces memory usage to support higher resolutions with reduced memory requirements
* enable saving depth data with default pipeline
```
make apply-patches
```

install vipe
```
make vipe-install
```

### Running
activate virtual environment (if not already active)
```
source .vipe_venv/bin/activate
```

preprocess images in data directory into a mp4 file and downscale the resolution to reduce memory usage.
```
./1_data_preprocessing.py
```

run vipe
```
python vipe/run.py pipeline=default streams=raw_mp4_stream streams.base_path=input.mp4
```

visualize results
```
make visualize
```