/*
 * Operating system has died. Known functions will be killed
 * after memmove.
 *
 * Make sure stack is not used.
 */

#include <asm/macros.h>
#include <debug_ll.h>
#include <eos_600d.h>

static inline void eos_600d_led_long(void)
{
	eos_600d_led_on();
	_sleep(0x2000000);
	eos_600d_led_off();
	_sleep(0x1000000);
}

static inline void eos_600d_led_short(void)
{
	eos_600d_led_on();
	_sleep(0x800000);
	eos_600d_led_off();
	_sleep(0x800000);
}

void __attribute__((noreturn)) my_restart()
{
	PUTS_LL("Hello, 115200 8n1 UART!\n");

	for(;;) {
		eos_600d_led_long();
		eos_600d_led_short();
	}

	while(1);
}
