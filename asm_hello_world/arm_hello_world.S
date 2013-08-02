/*
   vim: sw=8:et:ai

   Trivial serial output for Canon Digic 4.

   Based on register map for EOS 600D, see http://magiclantern.wikia.com/wiki/Register_Map
*/

/* Serial interface registers */
#define UART_BASE       0xC0800000
#define UART_TX         (UART_BASE + 0x0)
#define UART_RX         (UART_BASE + 0x4)
#define UART_ST         (UART_BASE + 0x14)

        .text
        .globl _start

		.org 0
_start:
        ldr   r1, =UART_TX
        ldr   r2, =hello_world_message

		.org 0x100
loop:   ldrb  r0, [r2]
        cmp   r0, #0
        beq   forever
        strb  r0, [r1]
        add   r2, #1

        ldr   r3, =10000

sleep:  sub   r3, #1
        cmp   r3, #0
        bne   sleep

        b     loop

forever:
        b     forever

hello_world_message:
        .ascii  "Hello, world!"
        .byte   13, 10
        .byte   0
