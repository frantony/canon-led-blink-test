/*
 * Operating system has died. Known functions will be killed
 * after memmove.
 *
 * Make sure stack is not used.
 */

#include <asm/macros.h>
#include <debug_ll.h>
#include <a1100.h>

static inline void a1100_led_long(void)
{
	a1100_led_on();
	_sleep(0x2000000);
	a1100_led_off();
	_sleep(0x1000000);
}

static inline void a1100_led_short(void)
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
		a1100_led_long();
		a1100_led_short();
	}

	while(1);
}
