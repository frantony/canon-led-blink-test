    .section .entry

    B       skip_fir_header

	.org	0x120
skip_fir_header:
    MRS		R0, CPSR
    BIC		R0, R0, #0x3F	/* Clear I,F,T */
    ORR		R0, R0, #0xD3	/* Set I,T, M=10011 == supervisor */
    MSR		CPSR, R0
	/* jump to C code */
	B		my_restart
