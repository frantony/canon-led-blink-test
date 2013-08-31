/*
 * Operating system has died. Known functions will be killed
 * after memmove.
 *
 * Make sure stack is not used.
 */

#include <asm/macros.h>
#include <debug_ll.h>
#include <a460.h>

static inline void a460_led_long(void)
{
	a460_led_on();
	_sleep(0x2000000);
	a460_led_off();
	_sleep(0x1000000);
}

static inline void a460_led_short(void)
{
	a460_led_on();
	_sleep(0x800000);
	a460_led_off();
	_sleep(0x800000);
}

void __attribute__((noreturn)) my_restart()
{
	PUTS_LL("Hello, 115200 8n1 UART!\n");

	for(;;) {
		a460_led_long();
		a460_led_short();
	}

	while(1);
}
