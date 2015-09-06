FLAGS =  --release --link-flags "-static"

all:
	crystal build src/connpass.cr -o bin/connpass $(FLAGS)
