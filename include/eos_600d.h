#ifndef __EOS_600D_H
#define __EOS_600D_H

#include <asm/io.h>

/* 600D LEDS */
#define EOS_600D_LED_SD      0xC0220134	/* sd-card (red) */

#define eos_600d_led_on() writel(0x46, EOS_600D_LED_SD)
#define eos_600d_led_off() writel(0x44, EOS_600D_LED_SD)

#endif	/* __EOS_600D_H */
