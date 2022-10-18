#include <msp430.h> 
#include <stdio.h>

int overflow = 0;
unsigned long addEightBit(int num1[], int num2[]);

/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	// two 8 bit binary numbers stored as arrays
	int binary1[8] = {1,1,0,1,1,1,0,0};
	int binary2[8] = {0,1,0,1,1,0,1,0};

	// add the two binary numbers and store the return value in sum


	unsigned long sum = addEightBit(binary1, binary2);

	sum = sum;
	overflow = overflow;

	return 0;
}

/**
 * Add two 8 bit binary numbers
 */
unsigned long addEightBit(int num1[], int num2[]) {

    // declaration of working variables
    int result[8] = {0,0,0,0,0,0,0,0};
    int carry = 0;
    int i;

    // perform binary addition
    for(i = 7; i >= 0; i--) {

        result[i] = num1[i] + num2[i] + carry;

        if(result[i] == 2) {
            result[i] = 0;
            carry = 1;
        } else if(result[i] == 3) {
            result[i] = 1;
            carry = 1;
        } else {
            carry = 0;
        }

    }

    // convert binary array sum to integer for return
    unsigned long sum = 0;
    unsigned long digit = 1;
    for(i = 7; i >=0; i--) {
        sum += result[i] * digit;
        digit *= 10;
    }

    // set the final carry bit to overflow and return the sum as an int
    overflow = carry;
    return sum;

}
