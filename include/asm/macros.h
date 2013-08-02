#ifndef __ASM_MACROS_H
#define __ASM_MACROS_H

static inline void _sleep(int delay)
{
	int i;

	for (i = 0; i < delay; i++) {
		asm ("nop\n");
		asm ("nop\n");
	}
}

#endif /* __ASM_MACROS_H */
