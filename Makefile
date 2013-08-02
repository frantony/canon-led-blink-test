CROSS_COMPILE=/home/antony/repos/ML/gcc-4.6.0/bin/arm-elf-

CC=$(CROSS_COMPILE)gcc
LD=$(CC)
OBJCOPY=$(CROSS_COMPILE)objcopy
OBJDUMP=$(CROSS_COMPILE)objdump
STRIP=$(CROSS_COMPILE)strip
NM=$(CROSS_COMPILE)nm
AR=$(CROSS_COMPILE)ar
RANLIB=$(CROSS_COMPILE)ranlib
SIZE=$(CROSS_COMPILE)size

# common flags
CFLAGS=-nostdinc -fno-strict-aliasing

# target-specific
CFLAGS+=-mtune=arm946e-s -mthumb-interwork

# optimizations
CFLAGS+=-O2 -fno-schedule-insns2

# warnings
CFLAGS+=-W -Wall

LDFLAGS=-nostdlib -Wl,--allow-shlib-undefined -Wl,--no-define-common,-EL,-T,link-boot.ld -Wl,-N,-Ttext,0x1900


all: DISKBOOT.BIN

ENCODE_DISKBOOT=tools/dancingbits
NEED_ENCODED_DISKBOOT=2

DEVNULL=/dev/null

DISKBOOT.BIN: main.bin $(ENCODE_DISKBOOT)
	dd if=/dev/zero bs=1k count=128 >> $< 2> $(DEVNULL)
	$(ENCODE_DISKBOOT) $< $@ $(NEED_ENCODED_DISKBOOT)

entry.o: entry.S
	$(CC) $(CFLAGS) -c -o $@ $^

main.o: main.c
	$(CC) $(CFLAGS) -c -o $@ $^

main.elf: main.o entry.o
	$(LD) $(LDFLAGS) -o $@ $^

main.bin: main.elf
	@echo $< \-\> $@
	$(OBJDUMP) -z -d main.elf > main.dump
	$(OBJCOPY) -O binary main.elf main.bin

.PHONY: clean
clean:
	rm -f *.BIN *.bin *.elf *.o *.dump
	make -C tools clean

$(ENCODE_DISKBOOT):
	make -C tools
