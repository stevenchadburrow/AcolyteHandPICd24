/*******************************************************************************
Copyright 2016 Microchip Technology Inc. (www.microchip.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

To request to license the code under the MLA license (www.microchip.com/mla_license), 
please contact mla_licensing@microchip.com
*******************************************************************************/


// THIS HAS BEEN MODIFIED FROM THE ORIGINAL!!!


#include <xc.h>

void serial_init()
{
	__builtin_write_OSCCONL(OSCCON & 0xBF);
	RPINR27bits.U4RXR = 2; // RP2 as U4RX
	RPOR1bits.RP3R = 21; // RP3 as U4TX
	__builtin_write_OSCCONL(OSCCON | 0x40);

	U4BRG = 103; // 103 -> 9600 baud
	
	U4MODEbits.STSEL = 0; // 1-Stop bit
	U4MODEbits.PDSEL = 0; // No Parity, 8-Data bits
	U4MODEbits.ABAUD = 0; // Auto-Baud disabled
	U4MODEbits.BRGH = 0; // Standard-Speed mode
	
	U4STAbits.UTXISEL0 = 0; // Interrupt after one TX character is transmitted
	U4STAbits.UTXISEL1 = 0;
	
	U4STAbits.URXISEL = 0; // interrupt after one RX character is received
	
	U4MODEbits.UARTEN = 1; // enable the UART (just RX?)
	U4STAbits.UTXEN = 1; // and specifically enable the TX
	
	// you can enable interrupts here if you want
};


unsigned char serial_transfer(unsigned char data)
{
	unsigned char value = 0x00;
 
	/*
	// check for errors
	if(U4STAbits.FERR == 1)
	{
		return;
	}
		
	// clear overrun error
	if(U4STAbits.OERR == 1)
	{	
		U4STAbits.OERR = 0;
		return;
	}

	// get data
	if(U4STAbits.URXDA == 1)
	{
		value = U1RXREG; // get character
	}
	*/
			
	while (U4STAbits.UTXBF == 1) { } // wait for clear buffer
	U4TXREG = data; // send character
	
	return value;
};


/** INCLUDES *******************************************************/
#include "usb.h"
#include "usb_host_hid.h"

#include "system.h"
#include "app_host_hid_keyboard.h"






/****************************************************************************
  Function:
    int main(void)

  Summary:
    main function

  Description:
    main function

  Precondition:
    None

  Parameters:
    None

  Return Values:
    int - exit code for main function

  Remarks:
    None
  ***************************************************************************/
int main(void)
{   
	ANSELA = 0;
    PORTA = 0;
	LATA = 0;
	TRISA = 0;
	//PORTAbits.RA0 = 0;
	PORTAbits.RA0 = 1;
  
    SYSTEM_Initialize(SYSTEM_STATE_USB_HOST);
    SYSTEM_Initialize(SYSTEM_STATE_USB_HOST_HID_KEYBOARD);

    //Initialize the stack
    USBHostInit(0);

    APP_HostHIDKeyboardInitialize();
	
	serial_init();
	
	for (unsigned int i=0; i<100; i++) { }
	
	serial_transfer('*');
	
    while(1)
    {
        USBHostTasks();
        USBHostHIDTasks();

        //Application specific tasks
        APP_HostHIDKeyboardTasks();
    }//end while
}//end main



/****************************************************************************
  Function:
    bool USB_ApplicationEventHandler( uint8_t address, USB_EVENT event,
                void *data, uint32_t size )

  Summary:
    This is the application event handler.  It is called when the stack has
    an event that needs to be handled by the application layer rather than
    by the client driver.

  Description:
    This is the application event handler.  It is called when the stack has
    an event that needs to be handled by the application layer rather than
    by the client driver.  If the application is able to handle the event, it
    returns true.  Otherwise, it returns false.

  Precondition:
    None

  Parameters:
    uint8_t address    - Address of device where event occurred
    USB_EVENT event - Identifies the event that occured
    void *data      - Pointer to event-specific data
    uint32_t size      - Size of the event-specific data

  Return Values:
    true    - The event was handled
    false   - The event was not handled

  Remarks:
    The application may also implement an event handling routine if it
    requires knowledge of events.  To do so, it must implement a routine that
    matches this function signature and define the USB_HOST_APP_EVENT_HANDLER
    macro as the name of that function.
  ***************************************************************************/
bool USB_HOST_APP_EVENT_HANDLER ( uint8_t address, USB_EVENT event, void *data, uint32_t size )
{
    switch( (int)event )
    {
        /* Standard USB host events ******************************************/
        case EVENT_VBUS_REQUEST_POWER:
        case EVENT_VBUS_RELEASE_POWER:
        case EVENT_HUB_ATTACH:
        case EVENT_UNSUPPORTED_DEVICE:
        case EVENT_CANNOT_ENUMERATE:
        case EVENT_CLIENT_INIT_ERROR:
        case EVENT_OUT_OF_MEMORY:
        case EVENT_UNSPECIFIED_ERROR:
            return true;
            break;

        /* HID Class Specific Events ******************************************/
        case EVENT_HID_RPT_DESC_PARSED:
            if(APP_HostHIDKeyboardReportParser() == true)
            {
                return true;
            }
            break;

        default:
            break;
    }

    return false;

}

