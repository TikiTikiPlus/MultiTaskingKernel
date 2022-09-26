#include "./wramp.h"
char timer;
int counter = 0;
int digit;
char character;
void printTimer(int c)
{
	//Loop while the TDR bit is not set
	while(!(WrampSp2->Stat & 2));
	//Write the character to the Tx register
	WrampSp2->Tx=c + '0';
}
char receiveChar()
{
	if(!(WrampSp2->Stat & 1));
	return WrampSp2->Rx;
}
void serial_main()
{
	int loop = 1;
	while(loop)
	{
		while(!(WrampSp2->Stat & 2));
		WrampSp2->Tx='\r';
		character = receiveChar();
		if(character)
		{
			if(character == '1')
			{	//print out things
				digit = counter/6000;
				digit = digit/10;
				digit = digit % 10;
				printTimer(digit);
				digit = counter/6000;
				digit = digit%10;
				printTimer(digit);
				//Write the character to the Tx register
				while(!(WrampSp2->Stat & 2));
				WrampSp2->Tx=':';
				digit = counter/1000;
				digit = digit % 6;
				printTimer(digit);
				digit = counter/100;
				digit = digit % 10;
				printTimer(digit);
			}
			if(character == '2')
			{
				digit = counter/100000;
				digit = digit % 10;
				printTimer(digit);
				digit = counter/10000;
				digit = digit % 10;
				printTimer(digit);
				digit = counter/1000;
				digit = digit % 10;
				printTimer(digit);
				digit = counter/100;
				digit = digit % 10;
				printTimer(digit);			//Write the character to the Tx register
				while(!(WrampSp2->Stat & 2));		
				WrampSp2->Tx='.';
				digit = counter/10;
				digit = digit % 10;
				printTimer(digit);
				digit = counter % 10;
				printTimer(digit);
			}
		 	if(character == '3')
			{
				digit = counter/100000;
				digit = digit % 10;
				printTimer(digit);
				digit = counter/10000;
				digit = digit % 10;
				printTimer(digit);
				digit = counter/1000;
				digit = digit % 10;
				printTimer(digit);
				digit = counter/100;
				digit = digit % 10;
				printTimer(digit);
				digit = counter/10;
				digit = digit % 10;
				printTimer(digit);
				digit = counter % 10;
				printTimer(digit);
			}
			if(character == 'q')
			{
				loop = 0;
				return;
			}
			
		}
		else
		{
				digit = counter/6000;
				digit = digit/10;
				digit = digit % 10;
				printTimer(digit);
				digit = counter/6000;
				digit = digit%10;
			
				printTimer(digit);
				//Write the character to the Tx register
				while(!(WrampSp2->Stat & 2));
				WrampSp2->Tx=':';
				digit = counter/1000;
				digit = digit % 6;
				printTimer(digit);
				digit = counter/100;
				digit = digit % 10;
				printTimer(digit);
		}
		while(!(WrampSp2->Stat & 2));
		WrampSp2->Tx='\r';
		WrampSp2->Tx=' ';
		WrampSp2->Tx=' ';
		while(!(WrampSp2->Stat & 2));
		WrampSp2->Tx=' ';
	}
	return;
}
