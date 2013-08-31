#ifndef __A460_H
#define __A460_H

#include <asm/io.h>

/* A460 IS LEDS */
#define A460_LED_DP      0xc0220084 /* direct-print (blue) */

#define a460_led_on() writel(0x46, A460_LED_DP)
#define a460_led_off() writel(0x44, A460_LED_DP)

#endif /* __A460_H */
