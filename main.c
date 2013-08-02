/*
 * Operating system has died. Known functions will be killed
 * after memmove.
 *
 * Make sure stack is not used.
 */

/* A1100 IS LEDS */
#define A1100_LED_DP      0xC02200CC    /* direct-print (blue) */
#define A1100_LED_FLASH   0xC02200D8    /* triggers flash */
#define A1100_LED_AF      0xC02200DC    /* auto-focus LED */

/* Serial interface registers */
#define UART_BASE       0xC0800000
#define UART_TX         (UART_BASE + 0x0)
#define UART_RX         (UART_BASE + 0x4)
#define UART_ST         (UART_BASE + 0x14)

#define writel(v,a)   *(volatile unsigned int *)(a) = (v)
#define writeb(v,a)   *(volatile unsigned char *)(a) = (v)

#define a1100_led_on() writel(0x46, A1100_LED_DP)
#define a1100_led_off() writel(0x44, A1100_LED_DP)

static inline void _sleep(int delay)
{
	int i;

	for (i = 0; i < delay; i++) {
		asm ("nop\n");
		asm ("nop\n");
	}
}

static inline void PUTC_LL(char ch)
{
	/* FIXME! need check UART status first */

	writeb(ch, UART_TX);
	_sleep(0x80000);
}

static inline void PUTS_LL(const char * str)
{
	while (*str) {
		if (*str == '\n') {
			PUTC_LL('\r');
		}
		PUTC_LL(*str);
		str++;
	}
}

static inline void led_long(void)
{
	a1100_led_on();
	_sleep(0x2000000);
	a1100_led_off();
	_sleep(0x1000000);
}

static inline void led_short(void)
{
	a1100_led_on();
	_sleep(0x800000);
	a1100_led_off();
	_sleep(0x800000);
}

void __attribute__((noreturn)) my_restart()
{
	PUTS_LL("Hello, 115200 8n1 UART!\n");

	for(;;) {
		led_long();
		led_short();
	}

	while(1);
}
