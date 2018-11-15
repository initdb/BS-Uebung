#variables
CC=gcc
CFLAGS=-I. -D USE_SPECIAL_ADD

DEPS = mathfunctions.h
OBJ = main.o mathfunctions.o 

#targets
%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

simple_prog: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

#.PHONY are targets that have no dependencies
.PHONY: clean
clean:
	rm -f *.o