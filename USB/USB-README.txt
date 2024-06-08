This is a copy from the MLA downloaded folder in the ~/Microchip folder.

The actual project is in:

apps/usb/host/firmware/hid_keyboard/exp16_pic24fj128gb204_pim.x

Don't rename it!!!  Everything is very specific to the linker...

Things I did to change it:

1. I first ran it as is.  It worked with the PIC24FJ128GB204 configuration.

2. I changed the device to PIC24FJ128GB202 in Set Project Configuation -> Customize.  (I also renamed that configuration, but not required.)  This caused a lot of errors of course.

3. From there I removed any files from the project that referenced "led" or "lcd", as I don't have those.  You might need to do this in the Configuration -> Customize -> File Inclusion.

4. I also removed from the #include files anything doing with "led" or "lcd".  

5. Then I commented out any LED_ or LCD_ or PRINT_ function calls, particularly in the app_host_hid_keyboard files.

6. In the system.c file, I commented the CONFIG bits out, and then used Set Config Bits tool to create new ones, then copy/paste into the system.c file.

/** CONFIGURATION Bits **********************************************/
// CONFIG1
#pragma config WDTPS = PS32768          // Watchdog Timer Postscaler Select (1:32,768)
#pragma config FWPSA = PR128            // WDT Prescaler Ratio Select (1:128)
#pragma config WINDIS = OFF             // Windowed WDT Disable (Standard Watchdog Timer)
#pragma config FWDTEN = OFF             // Watchdog Timer Enable (WDT disabled in hardware; SWDTEN bit disabled)
#pragma config ICS = PGx1               // Emulator Pin Placement Select bits (Emulator functions are shared with PGEC1/PGED1)
#pragma config LPCFG = OFF              // Low power regulator control (Disabled - regardless of RETEN)
#pragma config GWRP = OFF               // General Segment Write Protect (Write to program memory allowed)
#pragma config GCP = OFF                // General Segment Code Protect (Code protection is disabled)
#pragma config JTAGEN = OFF             // JTAG Port Enable (Disabled)

// CONFIG2
#pragma config POSCMD = NONE              // Primary Oscillator Select
#pragma config WDTCLK = LPRC            // WDT Clock Source Select bits (WDT uses LPRC)
#pragma config OSCIOFCN = ON            // OSCO Pin Configuration (OSCO/CLKO/RA3 functions as port I/O (RA3))
#pragma config FCKSM = CSECMD           // Clock Switching and Fail-Safe Clock Monitor Configuration bits 
#pragma config FNOSC = FRCPLL           // Initial Oscillator Select 
#pragma config ALTRB6 = APPEND          // Alternate RB6 pin function enable bit (Append the RP6/ASCL1/PMPD6 functions of RB6 to RA1 pin functions)
#pragma config ALTCMPI = CxINC_RB       // Alternate Comparator Input bit (C1INC is on RB13, C2INC is on RB9 and C3INC is on RA0)
#pragma config WDTCMX = WDTCLK          // WDT Clock Source Select bits (WDT clock source is determined by the WDTCLK Configuration bits)
#pragma config IESO = ON               // Internal External Switchover

// CONFIG3
#pragma config WPFP = WPFP127           // Write Protection Flash Page Segment Boundary (Page 127 (0x1FC00))
#pragma config SOSCSEL = ON             // SOSC Selection bits (SOSC circuit selected)
#pragma config WDTWIN = PS25_0          // Window Mode Watchdog Timer Window Width Select (Watch Dog Timer Window Width is 25 percent)
#pragma config PLLSS = PLL_FRC          // PLL Secondary Selection Configuration bit (PLL is fed by the Primary oscillator)
#pragma config BOREN = OFF              // Brown-out Reset Enable (Brown-out Reset Disabled)
#pragma config WPDIS = WPDIS            // Segment Write Protection Disable (Disabled)
#pragma config WPCFG = WPCFGDIS         // Write Protect Configuration Page Select (Disabled)
#pragma config WPEND = WPENDMEM         // Segment Write Protection End Page Select (Write Protect from WPFP to the last page of memory)

// CONFIG4
#pragma config DSWDTPS = DSWDTPS1F      // Deep Sleep Watchdog Timer Postscale Select bits (1:68719476736 (25.7 Days))
#pragma config DSWDTOSC = LPRC          // DSWDT Reference Clock Select (DSWDT uses LPRC as reference clock)
#pragma config DSBOREN = OFF            // Deep Sleep BOR Enable bit (DSBOR Disabled)
#pragma config DSWDTEN = OFF            // Deep Sleep Watchdog Timer Enable (DSWDT Disabled)
#pragma config DSSWEN = OFF             // DSEN Bit Enable (Deep Sleep operation is always disabled)
#pragma config PLLDIV = NODIV         // USB 96 MHz PLL Prescaler Select bits 
#pragma config I2C1SEL = DISABLE        // Alternate I2C1 enable bit (I2C1 uses SCL1 and SDA1 pins)
#pragma config IOL1WAY = OFF            // PPS IOLOCK Set Only Once Enable bit (The IOLOCK bit can be set and cleared using the unlock sequence)

7. It should work now.  Clean and Build, it should work.  If not, look for errors and eliminate them I guess.

8. After all of this, I deleted a lot of other files and configurations that I didn't need.  The whole MLA folder is 600 MB, what a waste.

9. I think that was it.  I will probably have to add some kind of feedback functions in place of the LED_ and LCD_ and PRINT_ functions.

10. Also, I might need to add specific things like clearing ANSELx registers, changing OSCCON accordingly, etc.  Chip specific stuff.
