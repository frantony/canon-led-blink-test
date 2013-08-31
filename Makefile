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

CFLAGS+=-Iinclude

LDFLAGS=-nostdlib -Wl,--allow-shlib-undefined -Wl,--no-define-common,-EL,-T,link-boot.ld -Wl,-N

all: PS.FIR

ENCODE_DISKBOOT=tools/dancingbits
NEED_ENCODED_DISKBOOT=2

DEVNULL=/dev/null

DISKBOOT.BIN: a460_main.bin

A460_PLATFORMID=12617

PAKWIF=tools/pakwif

PS.FIR: a460_main.bin $(PAKWIF)
	$(PAKWIF) $@ $^ $(A460_PLATFORMID) 0x01000101

a460_entry.o: a460_entry.S
	$(CC) $(CFLAGS) -c -o $@ $^

a460_main.o: a460_main.c
	$(CC) $(CFLAGS) -c -o $@ $^

a460_main: a460_main.o a460_entry.o
	$(LD) $(LDFLAGS) -Wl,-Ttext,0x1900 -o $@ $^

a460_main.bin: a460_main
	$(OBJDUMP) -z -d $< > $<.dump
	$(OBJCOPY) -O binary $< $@

.PHONY: a460_clean
a460_clean:
	rm -f DISKBOOT.BIN
	rm -f a460_main.bin a460_main a460_main.dump
	rm -f a460_main.o a460_entry.o

DISKBOOT.BIN: a1100_main.bin $(ENCODE_DISKBOOT)
	dd if=/dev/zero bs=1k count=128 >> $< 2> $(DEVNULL)
	$(ENCODE_DISKBOOT) $< $@ $(NEED_ENCODED_DISKBOOT)

a1100_entry.o: a1100_entry.S
	$(CC) $(CFLAGS) -c -o $@ $^

a1100_main.o: a1100_main.c
	$(CC) $(CFLAGS) -c -o $@ $^

a1100_main: a1100_main.o a1100_entry.o
	$(LD) $(LDFLAGS) -Wl,-Ttext,0x1900 -o $@ $^

a1100_main.bin: a1100_main
	$(OBJDUMP) -z -d $< > $<.dump
	$(OBJCOPY) -O binary $< $@

.PHONY: a1100_clean
a1100_clean:
	rm -f DISKBOOT.BIN
	rm -f a1100_main.bin a1100_main a1100_main.dump
	rm -f a1100_main.o a1100_entry.o

eos_600d_entry.o: eos_600d_entry.S
	$(CC) $(CFLAGS) -c -o $@ $^

eos_600d_main.o: eos_600d_main.c
	$(CC) $(CFLAGS) -c -o $@ $^

eos_600d_main: eos_600d_main.o eos_600d_entry.o
	$(LD) $(LDFLAGS) -Wl,-Ttext,0x00800000 -o $@ $^

eos_600d_main.bin: eos_600d_main
	$(OBJDUMP) -z -d $< > $<.dump
	$(OBJCOPY) -O binary $< $@

autoexec.bin: eos_600d_main.bin
	cp $< $@
	dd if=/dev/zero bs=1k count=400 >> $@

.PHONY: eos_600d_clean
eos_600d_clean:
	rm -f autoexec.bin
	rm -f eos_600d_main.bin eos_600d_main eos_600d_main.dump
	rm -f eos_600d_main.o eos_600d_entry.o

.PHONY: clean
clean: a460_clean a1100_clean eos_600d_clean
	make -C tools clean

$(ENCODE_DISKBOOT):
	make -C tools

$(PAKWIF):
	make -C tools
