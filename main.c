
/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/

/* Device header file */
#if defined(__XC16__)
    #include <xc.h>
#elif defined(__C30__)
    #if defined(__PIC24E__)
    	#include <p24Exxxx.h>
    #elif defined (__PIC24F__)||defined (__PIC24FK__)
	#include <p24Fxxxx.h>
    #elif defined(__PIC24H__)
	#include <p24Hxxxx.h>
    #endif
#endif

#include <stdint.h>        /* Includes uint16_t definition                    */
#include <stdbool.h>       /* Includes true/false definition                  */

/* Microcontroller MIPs (FCY) */
#define SYS_FREQ        10000000L
#define FCY             SYS_FREQ/2


// PIC24EP512GP204 Configuration Bit Settings

// 'C' source line config statements

// FICD
#pragma config ICS = PGD1               // ICD Communication Channel Select bits (Communicate on PGEC1 and PGED1)
#pragma config JTAGEN = OFF             // JTAG Enable bit (JTAG is disabled)

// FPOR
#pragma config ALTI2C1 = OFF            // Alternate I2C1 pins (I2C1 mapped to SDA1/SCL1 pins)
#pragma config ALTI2C2 = OFF            // Alternate I2C2 pins (I2C2 mapped to SDA2/SCL2 pins)
#pragma config WDTWIN = WIN25           // Watchdog Window Select bits (WDT Window is 25% of WDT period)

// FWDT
#pragma config WDTPOST = PS32768        // Watchdog Timer Postscaler bits (1:32,768)
#pragma config WDTPRE = PR128           // Watchdog Timer Prescaler bit (1:128)
#pragma config PLLKEN = ON              // PLL Lock Enable bit (Clock switch to PLL source will wait until the PLL lock signal is valid.)
#pragma config WINDIS = OFF             // Watchdog Timer Window Enable bit (Watchdog Timer in Non-Window mode)
#pragma config FWDTEN = OFF             // Watchdog Timer Enable bit (Watchdog timer enabled/disabled by user software)

// FOSC
#pragma config POSCMD = EC              // Primary Oscillator Mode Select bits (EC (External Clock) Mode)
#pragma config OSCIOFNC = ON            // OSC2 Pin Function bit (OSC2 is general purpose digital I/O pin)
#pragma config IOL1WAY = OFF            // Peripheral pin select configuration (Allow multiple reconfigurations)
#pragma config FCKSM = CSECMD           // Clock Switching Mode bits (Clock switching is enabled,Fail-safe Clock Monitor is disabled)

// FOSCSEL
#pragma config FNOSC = FRC              // Oscillator Source Selection (Internal Fast RC (FRC))
#pragma config IESO = OFF               // Two-speed Oscillator Start-up Enable bit (Start up with user-selected oscillator source)

// FGS
#pragma config GWRP = OFF               // General Segment Write-Protect bit (General Segment may be written)
#pragma config GCP = OFF                // General Segment Code-Protect bit (General Segment Code protect is Disabled)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>


/******************************************************************************/
/* Trap Function Prototypes                                                   */
/******************************************************************************/

/* <Other function prototypes for debugging trap code may be inserted here>   */

/* Use if INTCON2 ALTIVT=1 */
void __attribute__((interrupt,no_auto_psv)) _OscillatorFail(void);
void __attribute__((interrupt,no_auto_psv)) _AddressError(void);
void __attribute__((interrupt,no_auto_psv)) _StackError(void);
void __attribute__((interrupt,no_auto_psv)) _MathError(void);

#if defined(__PIC24F__)||defined(__PIC24H__)

/* Use if INTCON2 ALTIVT=0 */
void __attribute__((interrupt,no_auto_psv)) _AltOscillatorFail(void);
void __attribute__((interrupt,no_auto_psv)) _AltAddressError(void);
void __attribute__((interrupt,no_auto_psv)) _AltStackError(void);
void __attribute__((interrupt,no_auto_psv)) _AltMathError(void);

#endif

/* Default interrupt handler */
void __attribute__((interrupt,no_auto_psv)) _DefaultInterrupt(void);

#if defined(__PIC24E__)

/* These are additional traps in the 24E family.  Refer to the PIC24E
migration guide.  There are no Alternate Vectors in the 24E family. */
void __attribute__((interrupt,no_auto_psv)) _HardTrapError(void);
void __attribute__((interrupt,no_auto_psv)) _DMACError(void);
void __attribute__((interrupt,no_auto_psv)) _SoftTrapError(void);

#endif

/******************************************************************************/
/* Trap Handling                                                              */
/*                                                                            */
/* These trap routines simply ensure that the device continuously loops       */
/* within each routine.  Users who actually experience one of these traps     */
/* can add code to handle the error.  Some basic examples for trap code,      */
/* including assembly routines that process trap sources, are available at    */
/* www.microchip.com/codeexamples                                             */
/******************************************************************************/

/* Primary (non-alternate) address error trap function declarations */
void __attribute__((interrupt,no_auto_psv)) _OscillatorFail(void)
{
        INTCON1bits.OSCFAIL = 0;        /* Clear the trap flag */
        while(1);
}

void __attribute__((interrupt,no_auto_psv)) _AddressError(void)
{
        INTCON1bits.ADDRERR = 0;        /* Clear the trap flag */
        while (1);
}
void __attribute__((interrupt,no_auto_psv)) _StackError(void)
{
        INTCON1bits.STKERR = 0;         /* Clear the trap flag */
        while (1);
}

void __attribute__((interrupt,no_auto_psv)) _MathError(void)
{
        INTCON1bits.MATHERR = 0;        /* Clear the trap flag */
        while (1);
}

#if defined(__PIC24F__)||defined(__PIC24H__)

/* Alternate address error trap function declarations */
void __attribute__((interrupt,no_auto_psv)) _AltOscillatorFail(void)
{
        INTCON1bits.OSCFAIL = 0;        /* Clear the trap flag */
        while (1);
}

void __attribute__((interrupt,no_auto_psv)) _AltAddressError(void)
{
        INTCON1bits.ADDRERR = 0;        /* Clear the trap flag */
        while (1);
}

void __attribute__((interrupt,no_auto_psv)) _AltStackError(void)
{
        INTCON1bits.STKERR = 0;         /* Clear the trap flag */
        while (1);
}

void __attribute__((interrupt,no_auto_psv)) _AltMathError(void)
{
        INTCON1bits.MATHERR = 0;        /* Clear the trap flag */
        while (1);
}

#endif

/******************************************************************************/
/* Default Interrupt Handler                                                  */
/*                                                                            */
/* This executes when an interrupt occurs for an interrupt source with an     */
/* improperly defined or undefined interrupt handling routine.                */
/******************************************************************************/
void __attribute__((interrupt,no_auto_psv)) _DefaultInterrupt(void)
{
        while(1);
}

#if defined(__PIC24E__)

/* These traps are new to the PIC24E family.  Refer to the device Interrupt
chapter of the FRM to understand trap priority. */
void __attribute__((interrupt,no_auto_psv)) _HardTrapError(void)
{
    while(1);
}
void __attribute__((interrupt,no_auto_psv)) _DMACError(void)
{
    while(1);
}
void __attribute__((interrupt,no_auto_psv)) _SoftTrapError(void)
{
    while(1);
}

#endif


/******************************************************************************/
/* Global Variable Declaration                                                */
/******************************************************************************/

/* i.e. uint16_t <variable_name>; */

/******************************************************************************/
/* Main Program                                                               */
/******************************************************************************/

// only 90 used, but last 8 needed for other reasons
unsigned int line[128] __at(0x1000) = {
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000,
  0x0000, 0x0000, 0x0000, 0x0000
};

// 90 * 240 * 2-byte word = 43200 bytes
// 90 words * 4 pixels per word = 360 pixels horizontal
// 240 pixels vertically
// result: 360x240 with 16 colors
unsigned int screen[90*240] __at(0x1100);


// interrupt latency is 10 cycles
void __attribute__((__interrupt__, no_auto_psv)) _T1Interrupt(void)
{  
	// C always includes:
	// lnk #0
	// that adds 1 cycle!
  
	// Clear Timer1 interrupt flag
	asm("bclr.b 0x0800, #0x0003");

	// store registers for later
	asm("mov.w w0, 0x10F4");
	asm("mov.w w1, 0x10F6");
	asm("mov.w w2, 0x10F8");
	asm("mov.w w3, 0x10FA");
  
	// check line number
	asm("inc.w 0x10F0"); // increment line number
	asm("mov.w 0x10F0, w3"); // get line number
	asm("mov.w #0x01E1, w1"); // line 481 means coming from v-reset
	asm("mov.w #0x0013, w2"); // 19 cycles
	asm("cpseq.w w3, w1"); // compare line number
	asm("bra w2"); // takes 4 cycles, skip 14 instructions
	
	// v-reset interrupt
	// total cycle count here: 10 + 10 + 2 = 22 cycles
	
	// set values to be used
	asm("clr.w w3");
	asm("clr.w 0x10F0"); // line number = 0
	asm("mov.w #0x1100, w0");
	asm("mov.w w0, 0x10F2"); // screen address = 0x1100
	
	// set the periods to interrupt each scan line
	
	// turn off timer1
	asm("bclr.b 0x0105, #0x0007");
	
	// set prescaler
	asm("mov.w 0x0104, w1");
	asm("mov.w #0xFFCF, w0"); // prescaler of 1:1
	asm("and.w w1, w0, w0");
	asm("mov.w w0, 0x0104");
	
	// set period
	asm("mov.w #0x062F, w0"); // 1056 * 3 / 2 = 1584 cycles (minus one!)
	asm("mov.w w0, 0x0102");
	
	// set timer1
	asm("mov.w #0x0019, w0");
	asm("mov.w w0, 0x0100");
	
	// turn on timer1
	asm("bset.b 0x0105, #0x0007"); // 25 cycles is where it should be right now
	
	// 22 + 14 = 35 cycles
	
	// visible interrupt
	
	// needed for color anding
	asm("mov.w #0xF000, w2");

	// start counting timer cycles here
	
	// race the beam for 90 words, thus 360 pixels, 12 cycles each word
	asm("mov.w 0x1000, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1002, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1006, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1008, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x100A, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x100C, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x100E, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1010, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1012, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1014, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1016, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1018, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x101A, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x101C, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x101E, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1020, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1022, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1024, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1026, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1028, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x102A, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x102C, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x102E, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1030, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1032, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1034, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1036, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1038, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x103A, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x103C, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x103E, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1040, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1042, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1044, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1046, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1048, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x104A, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x104C, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x104E, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1050, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1052, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1054, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1056, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1058, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x105A, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x105C, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x105E, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1060, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1062, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1064, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1066, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1068, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x106A, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x106C, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x106E, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1070, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1072, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1074, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1076, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1078, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x107A, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x107C, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x107E, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1080, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1082, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1084, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1086, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1088, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x108A, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x108C, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x108E, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1090, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1092, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1094, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1096, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x1098, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x109A, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x109C, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x109E, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x10A0, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x10A2, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x10A4, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x10A6, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x10A8, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x10AA, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x10AC, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x10AE, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x10B0, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");

	asm("mov.w 0x10B2, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	asm("sl.w w1, #0x0004, w1");
	asm("and.w w1, w2, w0");
	asm("mov.w w0, 0x0E14");
	
	// that was 90 * 12 = 1080 cycles

	// turn pixels off
	asm("clr.w 0x0E14");

	// grab screen location
	asm("mov.w 0x10F2, w1");
	
	// that was 2 cycles

	// move pixels into line
	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1000");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1002");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1004");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1006");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1008");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x100A");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x100C");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x100E");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1010");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1012");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1014");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1016");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1018");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x101A");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x101C");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x101E");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1020");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1022");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1024");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1026");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1028");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x102A");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x102C");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x102E");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1030");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1032");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1034");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1036");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1038");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x103A");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x103C");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x103E");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1040");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1042");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1044");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1046");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1048");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x104A");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x104C");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x104E");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1050");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1052");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1054");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1056");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1058");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x105A");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x105C");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x105E");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1060");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1062");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1064");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1066");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1068");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x106A");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x106C");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x106E");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1070");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1072");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1074");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1076");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1078");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x107A");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x107C");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x107E");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1080");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1082");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1084");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1086");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1088");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x108A");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x108C");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x108E");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1090");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1092");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1094");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1096");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x1098");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x109A");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x109C");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x109E");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x10A0");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x10A2");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x10A4");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x10A6");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x10A8");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x10AA");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x10AC");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x10AE");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x10B0");

	asm("mov.w [w1++], w0");
	asm("mov.w w0, 0x10B2");
	
	// that was 90 * 2 = 180 cycles

	// if line even, then store screen location
	asm("btss.w w3, #0x0001");
	asm("mov.w w1, 0x10F2");

	// compare line number to 480, skip if greater
	asm("mov.w #0x01E0, w1");
	asm("mov.w #0x0005, w2"); // 5 cycles
	asm("cpsgt.w w3, w1");
	asm("bra w2"); // takes 4 cycles, skip 5 instructions

	// put old register values back in
	asm("mov.w 0x10F4, w0");
	asm("mov.w 0x10F6, w1");
	asm("mov.w 0x10F8, w2");
	asm("mov.w 0x10FA, w3");

	// return from interrupt, 3 cycles
	asm("RETFIE");
	
	// set the periods to interrupt on v-reset
	
	// turn off timer1
	asm("bclr.b 0x0105, #0x0007");
	
	// set prescaler
	asm("mov.w 0x0104, w1");
	asm("mov.w #0xFF7F, w0"); // prescaler of 1:8
	asm("and.w w1, w0, w0");
	asm("mov.w w0, 0x0104");
	
	// set period
	asm("mov.w #0x7296, w0"); // (minus one!)
	asm("mov.w w0, 0x0102");
	
	// clear timer1
	asm("clr.w 0x0100"); // 234686 cycles / 8 = 29335.75 ticks = 0x7297 with 6 NOPs until v-reset
	
	asm("nop");
	asm("nop");
	asm("nop");
	asm("nop");
	asm("nop");
	asm("nop"); // 6 NOPs to sync everything perfectly
	
	// turn on timer1
	asm("bset.b 0x0105, #0x0007"); 

	// put old register values back in
	asm("mov.w 0x10F4, w0");
	asm("mov.w 0x10F6, w1");
	asm("mov.w 0x10F8, w2"); 
	asm("mov.w 0x10FA, w3"); // takes 4 cycles

	// return from interrupt, 3 cycles
	asm("RETFIE");
	
	// C always includes:
	// ulnk
	// retfie
	// these don't add cycles because they are never reached!
};

// in C the arguments are in w0, w1, and w2
void pixels(unsigned int x, unsigned int y, unsigned int c)
{
	// C always includes:
	// lnk
	// mov.w w0, [w14]
	// mov.w w1, [w14+2]
	// mov.w w2, [w14+4]
  
	// Original C code was:
    // screen[(y * 90) + x] = c;
  
	asm("mov.w #0x005A, w0");
	asm("mul.uu w0, w1, w0");
	asm("mov.w w0, w1");
	asm("mov.w [w14], w1"); // assumes the C code!
	asm("add.w w1, w0, w0");
	asm("mov.w #0x1100, w1");
	asm("add.w w1, w0, w0");
	asm("mov.w w2, [w0]");
	
	// C always includes:
	// ulnk
	// return
};

int16_t main(void)
{	
	assemblyBegin();
  
	// change pins accordingly
	ANSELA = 0x0000;
	LATA = 0x0000;
	TRISA = 0xFFF3;
	ANSELB = 0x0000;
	LATB = 0x000C;
	TRISB = 0x00F3;
	ANSELC = 0x0000;
	LATC = 0xFFFF;
	TRISC = 0xFFFF;
	
  
	// The code below takes a 10 MHz external oscillator,
	// and uses the PLL to make an internal 120 MHz clock,
	// and thus 60 MIPS!!!
	
	// Make sure the CONFIG bits are set correctly:
	// FNOSC = FRC
	// IESO = OFF
	// FCKSM = CSECMD
	// OSCIOFNC = ON
	// POSCMD = EC
	
	// Configure PLL prescaler, PLL postscaler, PLL divisor
	PLLFBD = 46; // M = 48
	CLKDIVbits.PLLPOST = 0; // N2 = 2
	CLKDIVbits.PLLPRE = 0; // N1 = 2
	
	// Initiate Clock Switch to Primary Oscillator with PLL (NOSC = 0b011)
	__builtin_write_OSCCONH(0x03);
	__builtin_write_OSCCONL(OSCCON | 0x01);
	
	// Wait for Clock Switch to occur
	while (OSCCONbits.COSC != 0b011) { }
	
	// Wait for PLL to lock
	while (OSCCONbits.LOCK != 1) { }
	
	// With an external 10 MHz clock, this PIC24 *should*
	// now be running internally at 120 MHz, thus 60 MIPS!!!
	
	
	// sets Output Compare to appropriate pins
	__builtin_write_OSCCONL(OSCCON & ~(1<<6));
	RPOR3 = 0x1213; // audio channels on OC3 and OC4
	RPOR4 = 0x1011; // v-sync and h-sync to OC1 and OC2
	__builtin_write_OSCCONL(OSCCON | (1<<6));
	
	
	// Timer2 is used with Output Compare for V-SYNC signal
	OC1CON1 = 0; // clear output compare bits
	OC1CON2 = 0; // clear output compare bits
	OC1CON1bits.OCTSEL = 0x02; // uses Timer2
	OC1R = 0x3A33; // v-sync rise
	OC1RS = 0x3A96; // v-sync fall
	T2CON = 0; // set timer
	TMR2 = 0; // zero counter
	T2CONbits.TCKPS = 0x02; // prescale of 1:64 selected
	PR2 = 0x3CB6; // v-reset (minus one!)
	OC1CON2bits.SYNCSEL = 0x0C; // uses Timer2
	OC1CON1bits.OCM = 0x05; // double continuous pulse
	
	
	// Timer3 is used with Output Compare for H-SYNC signal
	OC2CON1 = 0; // clear output compare bits
	OC2CON2 = 0; // clear output compare bits
	OC2CON1bits.OCTSEL = 0x01; // uses Timer3
	OC2R = 0x0329; // h-sync rise
	OC2RS = 0x03E9; // h-sync fall
	T3CON = 0; // reset timer
	TMR3 = 0; // zero counter
	PR3 = 0x062F; // h-reset (minus one!)
	OC2CON2bits.SYNCSEL = 0x0D; // uses Timer3
	OC2CON1bits.OCM = 0x05; // double continuous pulse
	
	
	// Timer4 is used with Output Compare for AUDIO-A signal
	OC3CON1 = 0; // clear output compare bits
	OC3CON2 = 0; // clear output compare bits
	OC3CON1bits.OCTSEL = 0x02; // uses Timer4
	OC3R = 1000; // toggle
	T4CON = 0; // set timer
	TMR4 = 0; // zero counter
	T4CONbits.TCKPS = 0x01; // prescale of 1:8 selected
	PR4 = 3000; // reset
	OC3CON2bits.SYNCSEL = 0x0E; // uses Timer4
	OC3CON1bits.OCM = 0x03; // single continuous pulse
	
	
	// Timer5 is used with Output Compare for AUDIO-B signal
	OC4CON1 = 0; // clear output compare bits
	OC4CON2 = 0; // clear output compare bits
	OC4CON1bits.OCTSEL = 0x03; // uses Timer5
	OC4R = 1000; // toggle
	T5CON = 0; // set timer
	TMR5 = 0; // zero counter
	T5CONbits.TCKPS = 0x01; // prescale of 1:8 selected
	PR5 = 3000; // reset
	OC4CON2bits.SYNCSEL = 0x0F; // uses Timer5
	OC4CON1bits.OCM = 0x03; // single continuous pulse
	
	
	// Timer1 used for interrupts to race-the-beam
	T1CONbits.TON = 0; // turn timer off
	T1CONbits.TCS = 0; // use internal instructions
	T1CONbits.TGATE = 0; // disable gated mode
	T1CONbits.TCKPS = 0b00; // no prescalar
	TMR1 = 0x00; // timer counter
	PR1 = 0x0604; // timer period on last line of v-blank (minus one!)
	IPC0bits.T1IP = 0x01; // interrupt priority
	IFS0bits.T1IF = 0; // interrupt flag
	IEC0bits.T1IE = 1; // enable interrupt
	
	
	// turn on interrupts globally here!
	INTCON1 = 0;
	INTCON2 = 0;
	INTCON3 = 0;
	INTCON4 = 0;
	INTCON2bits.GIE = 1; 
	
	// expecting v-reset interrupt next
	asm("mov.w #0x0258, w0"); // line 600
	asm("mov.w w0, 0x10F0");
	
	// turn on timer3 (h-sync)
	asm("bset.b 0x0113, #0x0007"); // 1543 cycles away from interrupt
	// turn on timer2 (v-sync)
	asm("bset.b 0x0111, #0x0007"); // 1542 cycles away from interrupt
	// turn on timer1 (interrupts)
	asm("bset.b 0x0105, #0x0007"); // 1541 cycles away from interrupt
	

	// TESTING BELOW!
	
	for (unsigned int i=0; i<240; i++)
	{
		for (unsigned int j=0; j<90; j++)
		{
			screen[i * 90 + j] = 0x0000;
		}
	}
	
	pixels(20, 20, 0xB70F);
	
    while (1)
    {	
		if (PORTAbits.RA0 == 0) pixels(20, 22, 0xE1E1);
		else pixels(20, 22, 0x0FA5);
		
		if (PORTAbits.RA1 == 0) pixels(20, 23, 0xE1E1);
		else pixels(20, 23, 0x0FA5);
		
		if (PORTBbits.RB0 == 0) pixels(20, 24, 0xE1E1);
		else pixels(20, 24, 0x0FA5);
		
		if (PORTBbits.RB1 == 0) pixels(20, 25, 0xE1E1);
		else pixels(20, 25, 0x0FA5);
		
		if (PORTCbits.RC0 == 0) pixels(20, 26, 0xE1E1);
		else pixels(20, 26, 0x0FA5);
		
		if (PORTCbits.RC1 == 0) pixels(20, 27, 0xE1E1);
		else pixels(20, 27, 0x0FA5);
		
		if (PORTAbits.RA4 == 0) pixels(20, 28, 0xE1E1);
		else pixels(20, 28, 0x0FA5);
		
		if (PORTBbits.RB4 == 0) pixels(20, 29, 0xE1E1);
		else pixels(20, 29, 0x0FA5);
    }
}
