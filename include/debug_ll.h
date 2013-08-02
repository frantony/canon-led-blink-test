#ifndef __INCLUDE_DEBUG_LL_H__
#define __INCLUDE_DEBUG_LL_H__

#include <mach/debug_ll_digic4.h>

# define PUTHEX_LL(value)  ({ unsigned long v = (unsigned long) (value); \
			     int i; unsigned char ch; \
			     for (i = 8; i--; ) {\
			     ch = ((v >> (i*4)) & 0xf);\
			     ch += (ch >= 10) ? 'a' - 10 : '0';\
			     PUTC_LL (ch); }})

/*
 * Be careful with PUTS_LL, it only works if the binary is running at the
 * link address which often is not the case during early startup. If in doubt
 * don't use it.
 */
static __inline__ void PUTS_LL(const char * str)
{
	while (*str) {
		if (*str == '\n') {
			PUTC_LL('\r');
		}
		PUTC_LL(*str);
		str++;
	}
}

#endif /* __INCLUDE_DEBUG_LL_H__ */
