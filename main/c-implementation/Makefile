CC=/usr/bin/gcc
LDFLAGS=

SOURCES= generator.c
HEADERS= 

all: generator

# Implementation using traditional multiplication

generator: $(HEADERS) $(SOURCES)
	$(CC) -o $@ $(SOURCES) $(LDFLAGS) -g

.PHONY: clean

# Clean objects, request and response files

clean:
	-rm generator