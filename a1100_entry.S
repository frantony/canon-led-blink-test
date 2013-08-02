    .section .entry

	/* jump to C code */
	MOV     SP, #0x1900
	MOV     R11, #0
	B	my_restart
