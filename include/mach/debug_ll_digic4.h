#ifndef __INCLUDE_DEBUG_LL_DIGIC4DIGIC4H__
#define __INCLUDE_DEBUG_LL_DIGIC4DIGIC4H__

#include <asm/io.h>

/* Serial interface registers */
#define UART_BASE       0xC0800000
#define UART_TX         (UART_BASE + 0x0)
#define UART_RX         (UART_BASE + 0x4)
#define UART_ST         (UART_BASE + 0x14)

static inline void PUTC_LL(char ch)
{
	/* FIXME! need check UART status first */

	writeb(ch, UART_TX);
	_sleep(0x80000);
}

#endif /* __INCLUDE_DEBUG_LL_DIGIC4H__ */
