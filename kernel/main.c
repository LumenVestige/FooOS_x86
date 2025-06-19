
#include "lib.h"
#include "printk.h"

void Start_Kernel(void)
{
	color_printk(RED, BLACK, "Start Kernel OK!\n");

	while(1)
		;
}
