.PHONY: py-install vipe-install

VENV := .venv
PYTHON := python3

py-install:
	$(PYTHON) -m venv $(VENV)
	$(VENV)/bin/pip install --upgrade pip
	$(VENV)/bin/pip install -r requirements.txt
	$(VENV)/bin/pip install -r vipe/envs/requirements.txt --extra-index-url https://download.pytorch.org/whl/cu128

vipe-install:
	$(VENV)/bin/pip install --no-build-isolation -e vipe/.
