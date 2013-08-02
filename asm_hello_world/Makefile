# Makefile for arm_hello_world
# ./qemu-1.4.0/arm-softmmu/qemu-system-arm -nographic -M ML-600D

CROSS_COMPILE=/home/antony/repos/ML/gcc-arm-none-eabi-4_7-2013q2/bin/arm-none-eabi-

CC=$(CROSS_COMPILE)gcc
LD=$(CROSS_COMPILE)ld
OBJCOPY=$(CROSS_COMPILE)objcopy

CFLAGS=-nostdinc -fno-pic -Wall -g
LDFLAGS=-nostdlib -g -Ttext 0x00800120

.PHONY: all
all: autoexec.bin

autoexec.bin: arm_hello_world.bin
	dd if=/dev/zero of=autoexec.bin bs=1k count=1
	dd if=arm_hello_world.bin of=autoexec.bin seek=288 bs=1 conv=notrunc

.PHONY: clean
clean:
	@rm -f arm_hello_world *.o arm_hello_*.bin autoexec.bin

arm_hello_world.bin: arm_hello_world
	$(OBJCOPY) -S -j .text --output-target binary $< $@

arm_hello_world: arm_hello_world.o
	$(LD) -o $@ $(LDFLAGS) $<

arm_hello_world.o: arm_hello_world.S
	$(CC) -c $(CFLAGS) $<
