.PHONY: update-submodules update-lfs pull py-install vipe-install

VENV := .venv
PYTHON := python3

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
	@for patch in patches/*.patch; do \
		if [ -f "$$patch" ]; then \
			echo "Applying $$patch"; \
			(cd vipe && git am "$$OLDPWD/$$patch") || exit 1; \
		fi \
	done
	@echo "All patches applied successfully!"
