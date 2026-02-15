.PHONY: update-submodules update-lfs pull py-install vipe-install

GS_VENV := .gs_venv
VENV := .venv
PYTHON := python3

install-conda:
	wget -qO ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && bash ~/miniconda.sh -b -p $HOME/miniconda3 && rm ~/miniconda.sh && eval "$($HOME/miniconda3/bin/conda shell.bash hook)" && conda init

update-submodules:
	git submodule update --init --recursive

update-lfs:
	git lfs pull

pull: update-submodules update-lfs

py-install:
	$(PYTHON) -m venv $(VENV)
	$(VENV)/bin/pip install --upgrade pip
	$(VENV)/bin/pip install -r requirements.txt
	$(VENV)/bin/pip install -r vipe/envs/requirements.txt --extra-index-url https://download.pytorch.org/whl/cu128

vipe-install:
	$(VENV)/bin/pip install --no-build-isolation -e vipe/.

apply-patches:
	@echo "Applying patches"
		@for patch in vipe_patches/*.patch; do \
			if [ -f "$$patch" ]; then \
				echo "Processing $$patch"; \
					(cd vipe && git apply --check "$$OLDPWD/$$patch" >/dev/null 2>&1 && \
						git am "$$OLDPWD/$$patch" || \
						echo "$$patch already applied, skipping"); \
			fi; \
		done
	@echo "All patches applied successfully!"

gs-install:
	@echo "Creating conda environment '$(GS_VENV)'..."
	conda env create -f gaussian-splatting/environment.yml -n $(GS_VENV)
	@echo "Environment '$(GS_VENV)' created successfully."

# Optional: update an existing environment
gs-update:
	@echo "Updating conda environment '$(GS_VENV)'..."
	conda env update -f gaussian-splatting/environment.yml -n $(GS_VENV)
	@echo "Environment '$(GS_VENV)' updated successfully."

# Activate environment (example)
gs-activate:
	@echo "To activate the environment, run:"
	@echo "conda activate $(GS_VENV)"
