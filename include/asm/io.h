#ifndef __ASM_ARM_IO_H
#define __ASM_ARM_IO_H

#define writel(v,a)   *(volatile unsigned int *)(a) = (v)
#define writeb(v,a)   *(volatile unsigned char *)(a) = (v)

#endif /* __ASM_ARM_IO_H */
