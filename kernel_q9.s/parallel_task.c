#include "./wramp.h"
/**
*
*
*
*
*
**/
int switches = 0;
int mask;
int buttons = 0;
char digits;
int loop = 0;
int currentmode= 0;
void button1()
{
			digits = switches % 16;
			WrampParallel->LowerRightSSD = digits;
			switches >>= 4;
			digits = switches % 16;	
			WrampParallel->LowerLeftSSD = digits;
			switches >>= 4;
			digits = switches % 16;
			WrampParallel->UpperRightSSD = digits;
			switches >>= 4;
			digits = switches % 16;
			WrampParallel->UpperLeftSSD = digits;
}
void button2()
{
			digits = switches % 10;
			WrampParallel->LowerRightSSD = digits;
			switches = switches / 10;
			digits = switches % 10;	
			WrampParallel->LowerLeftSSD = digits;
			switches = switches / 10;
			digits = switches % 10;	
			WrampParallel->UpperRightSSD = digits;
			switches = switches / 10;
			digits = switches % 10;	
			WrampParallel->UpperLeftSSD = digits;
}
void parallel_main() {
	switches = WrampParallel->Switches;
	button1();
	loop = 1;
	//Infinite loop
	while(loop) {
		buttons = WrampParallel->Buttons;
		switches = WrampParallel->Switches;
		
			if (buttons == 2)
			{
				currentmode = 1;
			}
			if (buttons == 4)
			{
				loop=0;
			}
			if(buttons == 1)
			{
				currentmode = 0;
			}
			if (currentmode == 0)
			{
				button1();
			}
			else
			{
				button2();
			}
		
}
return;
}
