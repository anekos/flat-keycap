PROJECT_NAME=$(shell basename $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
FILENAME=dist/$(PROJECT_NAME).stl

.PHONY: preview
preview:
	openscad --hardwarnings main.scad

.PHONY: build
build: $(FILENAME)

.PHONY: $(FILENAME)
$(FILENAME): main.scad
	mkdir -p dist
	openscad --hardwarnings -o $(FILENAME) main.scad
