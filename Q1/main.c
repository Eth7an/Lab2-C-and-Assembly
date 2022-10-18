#include <msp430.h> 

float partB = 0.0;

/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	int partA = 0;
	partA++;

	partB--;

	unsigned char partCOne = 0x01;
	unsigned char partCTwo = 0x10;

	unsigned char partCResult = partCOne|partCTwo;
	partCResult = partCOne&partCTwo;

	return 0;
}
