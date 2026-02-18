.PHONY: update-submodules update-lfs pull vipe-install vipe-install apply-patches visualize

VIPE_VENV := .vipe_venv
PYTHON := python3

install-git-lfs:
	sudo apt update
	sudo apt install git-lfs

update-submodules:
	git submodule update --init --recursive

update-lfs:
	git lfs pull

pull: update-submodules update-lfs

vipe-install:
	$(PYTHON) -m venv $(VIPE_VENV)
	$(VIPE_VENV)/bin/pip install --upgrade pip
	$(VIPE_VENV)/bin/pip install -r requirements.txt
	$(VIPE_VENV)/bin/pip install -r vipe/envs/requirements.txt --extra-index-url https://download.pytorch.org/whl/cu128
	$(VIPE_VENV)/bin/pip install --no-build-isolation -e vipe/.

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

visualize:
	vipe visualize vipe_results
