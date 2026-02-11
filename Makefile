.PHONY: py-install

VENV := .venv
PYTHON := python3

py-install:
	$(PYTHON) -m venv $(VENV)
	$(VENV)/bin/pip install --upgrade pip
	$(VENV)/bin/pip install -r requirements.txt
