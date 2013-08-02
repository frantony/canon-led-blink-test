#ifndef __A1100_H
#define __A1100_H

#include <asm/io.h>

/* A1100 IS LEDS */
#define A1100_LED_DP      0xC02200CC    /* direct-print (blue) */
#define A1100_LED_FLASH   0xC02200D8    /* triggers flash */
#define A1100_LED_AF      0xC02200DC    /* auto-focus LED */

#define a1100_led_on() writel(0x46, A1100_LED_DP)
#define a1100_led_off() writel(0x44, A1100_LED_DP)

#endif	/* __A1100_H */
