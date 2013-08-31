all: dancingbits pakwif

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

dancingbits: dancingbits.o
	$(CC) $(CFLAGS) -o $@ $^

pakwif: pakwif.o
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -f *.o dancingbits pakwif
