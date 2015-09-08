FLAGS = --release
DEPS  = crystal deps
BUILD = crystal build

.PHONY: build deps clean

default: all

all: deps build

build:
	mkdir -p bin
	$(BUILD) src/notify.cr -o bin/notify $(FLAGS)
	$(BUILD) src/connpass.cr -o bin/connpass $(FLAGS)

deps:
	$(DEPS)

clean:
	rm -rf bin
	rm -rf .deps
	rm -rf .crystal
	rm -rf libs
