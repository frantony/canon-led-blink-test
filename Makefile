CROSS_COMPILE=/home/antony/repos/ML/gcc-4.6.0/bin/arm-elf-

CC=$(CROSS_COMPILE)gcc
OBJCOPY=$(CROSS_COMPILE)objcopy
OBJDUMP=$(CROSS_COMPILE)objdump
STRIP=$(CROSS_COMPILE)strip
NM=$(CROSS_COMPILE)nm
AR=$(CROSS_COMPILE)ar
RANLIB=$(CROSS_COMPILE)ranlib
SIZE=$(CROSS_COMPILE)size
CFLAGS=-fno-inline -Os -fno-strict-aliasing -fno-schedule-insns2 -mtune=arm946e-s -mthumb-interwork -I../../include -I../../core -I../../modules -I../../platform/a1100 -I. -DCORE_FILE="../../core/main.bin" -DRESET_FILE="./resetcode/main.bin" -DPLATFORM="a1100" -DPLATFORMSUB="100c" -DPLATFORMID=12739 -DCAMERA_a1100=1 -DVER_CHDK -DHDK_VERSION="CHDK" -DBUILD_NUMBER="1.2.0" -DBUILD_SVNREV="0" -Wall -Wno-unused -Wno-format -DOPT_GAMES -DOPT_CURVES -DOPT_EDGEOVERLAY -DOPT_DEBUGGING -DOPT_PTP -nostdinc

LD=$(CC)


all: DISKBOOT.BIN

ENCODE_DISKBOOT=tools/dancingbits
NEED_ENCODED_DISKBOOT=2

DEVNULL=/dev/null

DISKBOOT.BIN: main.bin $(ENCODE_DISKBOOT)
	dd if=/dev/zero bs=1k count=128 >> main.bin 2> $(DEVNULL)
	$(ENCODE_DISKBOOT) $< $@ $(NEED_ENCODED_DISKBOOT)

entry.o: entry.S
	$(CC) $(CFLAGS) -c -o entry.o entry.S

main.o: main.c
	$(CC) $(CFLAGS) -c -o main.o main.c

main.elf: main.o entry.o
	$(LD) -o main.elf entry.o main.o -nostdlib -Wl,--allow-shlib-undefined -Wl,--no-define-common,-EL,-T,link-boot.ld -Wl,-N,-Ttext,0x1900

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
