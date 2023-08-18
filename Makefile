.PHONY: all

SHELL := /bin/bash

all:
	@source .venv/bin/activate && ./build.py
