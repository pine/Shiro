FLAGS =  --release

all:
	mkdir -p bin
	crystal build src/connpass.cr -o bin/connpass $(FLAGS)
