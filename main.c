/*
 * Operating system has died. Known functions will be killed
 * after memmove.
 *
 * Make sure stack is not used.
 */

#define _LED_DP      0xC02200CC    // direct-print (blue)
#define _LED_FLASH   0xC02200D8    // Triggers flash
#define _LED_AF      0xC02200DC    // Auto-focus LED

#define writel(v,a)   *(volatile unsigned int *)(a) = (v)

#define _led_on() writel(0x46, _LED_DP)
#define _led_off() writel(0x44, _LED_DP)

#define _sleep(delay) \
	{ \
		int i; \
	\
		for (i = 0; i < delay; i++) { \
			asm ("nop\n"); \
			asm ("nop\n"); \
		} \
	}


void __attribute__((noreturn)) my_restart()
{

	for(;;) {
		_led_on();
		_sleep(0x2000000);
		_led_off();
		_sleep(0x1000000);

		_led_on();
		_sleep(0x2000000);
		_led_off();
		_sleep(0x1000000);

		_led_on();
		_sleep(0x2000000);
		_led_off();
		_sleep(0x1000000);

		_led_on();
		_sleep(0x800000);
		_led_off();
		_sleep(0x800000);

		_led_on();
		_sleep(0x800000);
		_led_off();
		_sleep(0x800000);

		_led_on();
		_sleep(0x800000);
		_led_off();
		_sleep(0x800000);

		_led_off();
		_sleep(0x3000000);
	}

	while(1);
}
