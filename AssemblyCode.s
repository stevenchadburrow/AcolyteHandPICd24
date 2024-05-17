.global _assemblyMain
.global _pixels
.global _T1Interrupt

_assemblyMain:
    clr.w w0 ; dummy statement
    return
    
; assumes that C has put
; w0 = X-value
; w1 = Y-value
; w2 = color data
_pixels: 
    push w0 ; store original w0
    mov.w #0x005A, w0 ; move 90 into w0
    mul.uu w0, w1, w0 ; multiply by w1
    pop w1 ; grab original w0, put in w1
    add.w w1, w0, w0 ; add w1 to w0
    mov.w #0x1100, w1 ; screen data location
    add.w w1, w0, w0 ; add w1 to w0
    mov.w w2, [w0] ; move color data into screen data location
    return
    
_T1Interrupt:
    ; Interrupt takes 10 cycles to start
    nop ; adding one dummy instruction because C includes lnk #0
    
    ; Clear Timer1 interrupt flag
    bclr.b 0x0800, #0x0003

    ; store registers for later
    mov.w w0, 0x10F4
    mov.w w1, 0x10F6
    mov.w w2, 0x10F8
    mov.w w3, 0x10FA

    ; check line number
    inc.w 0x10F0 ; increment line number
    mov.w 0x10F0, w3 ; get line number
    mov.w #0x01E1, w1 ; line 481 means coming from v-reset
    mov.w #0x0013, w2 ; 19 cycles
    cpseq.w w3, w1 ; compare line number
    bra w2 ; takes 4 cycles, skip 14 instructions

    ; v-reset interrupt
    ; total cycle count here: 10 + 10 + 2 = 22 cycles

    ; set values to be used
    clr.w w3
    clr.w 0x10F0 ; line number = 0
    mov.w #0x1100, w0
    mov.w w0, 0x10F2 ; screen address = 0x1100

    ; set the periods to interrupt each scan line

    ; turn off timer1
    bclr.b 0x0105, #0x0007

    ; set prescaler
    mov.w 0x0104, w1
    mov.w #0xFFCF, w0 ; prescaler of 1:1
    and.w w1, w0, w0
    mov.w w0, 0x0104

    ; set period
    mov.w #0x062F, w0 ; 1056 * 3 / 2 = 1584 cycles (minus one!)
    mov.w w0, 0x0102

    ; set timer1
    mov.w #0x0019, w0
    mov.w w0, 0x0100

    ; turn on timer1
    bset.b 0x0105, #0x0007 ; 25 cycles is where it should be right now

    ; 22 + 14 = 35 cycles

    ; visible interrupt

    ; needed for color anding
    mov.w #0xF000, w2

    ; start counting timer cycles here

    ; race the beam for 90 words, thus 360 pixels, 12 cycles each word
    mov.w 0x1000, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1002, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1006, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1008, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x100A, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x100C, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x100E, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1010, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1012, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1014, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1016, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1018, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x101A, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x101C, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x101E, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1020, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1022, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1024, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1026, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1028, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x102A, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x102C, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x102E, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1030, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1032, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1034, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1036, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1038, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x103A, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x103C, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x103E, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1040, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1042, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1044, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1046, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1048, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x104A, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x104C, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x104E, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1050, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1052, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1054, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1056, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1058, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x105A, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x105C, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x105E, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1060, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1062, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1064, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1066, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1068, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x106A, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x106C, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x106E, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1070, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1072, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1074, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1076, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1078, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x107A, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x107C, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x107E, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1080, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1082, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1084, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1086, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1088, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x108A, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x108C, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x108E, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1090, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1092, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1094, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1096, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x1098, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x109A, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x109C, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x109E, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x10A0, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x10A2, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x10A4, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x10A6, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x10A8, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x10AA, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x10AC, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x10AE, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x10B0, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    mov.w 0x10B2, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14
    sl.w w1, #0x0004, w1
    and.w w1, w2, w0
    mov.w w0, 0x0E14

    ; that was 90 * 12 = 1080 cycles

    ; turn pixels off
    clr.w 0x0E14

    ; grab screen location
    mov.w 0x10F2, w1

    ; that was 2 cycles

    ; move pixels into line
    mov.w [w1++], w0
    mov.w w0, 0x1000

    mov.w [w1++], w0
    mov.w w0, 0x1002

    mov.w [w1++], w0
    mov.w w0, 0x1004

    mov.w [w1++], w0
    mov.w w0, 0x1006

    mov.w [w1++], w0
    mov.w w0, 0x1008

    mov.w [w1++], w0
    mov.w w0, 0x100A

    mov.w [w1++], w0
    mov.w w0, 0x100C

    mov.w [w1++], w0
    mov.w w0, 0x100E

    mov.w [w1++], w0
    mov.w w0, 0x1010

    mov.w [w1++], w0
    mov.w w0, 0x1012

    mov.w [w1++], w0
    mov.w w0, 0x1014

    mov.w [w1++], w0
    mov.w w0, 0x1016

    mov.w [w1++], w0
    mov.w w0, 0x1018

    mov.w [w1++], w0
    mov.w w0, 0x101A

    mov.w [w1++], w0
    mov.w w0, 0x101C

    mov.w [w1++], w0
    mov.w w0, 0x101E

    mov.w [w1++], w0
    mov.w w0, 0x1020

    mov.w [w1++], w0
    mov.w w0, 0x1022

    mov.w [w1++], w0
    mov.w w0, 0x1024

    mov.w [w1++], w0
    mov.w w0, 0x1026

    mov.w [w1++], w0
    mov.w w0, 0x1028

    mov.w [w1++], w0
    mov.w w0, 0x102A

    mov.w [w1++], w0
    mov.w w0, 0x102C

    mov.w [w1++], w0
    mov.w w0, 0x102E

    mov.w [w1++], w0
    mov.w w0, 0x1030

    mov.w [w1++], w0
    mov.w w0, 0x1032

    mov.w [w1++], w0
    mov.w w0, 0x1034

    mov.w [w1++], w0
    mov.w w0, 0x1036

    mov.w [w1++], w0
    mov.w w0, 0x1038

    mov.w [w1++], w0
    mov.w w0, 0x103A

    mov.w [w1++], w0
    mov.w w0, 0x103C

    mov.w [w1++], w0
    mov.w w0, 0x103E

    mov.w [w1++], w0
    mov.w w0, 0x1040

    mov.w [w1++], w0
    mov.w w0, 0x1042

    mov.w [w1++], w0
    mov.w w0, 0x1044

    mov.w [w1++], w0
    mov.w w0, 0x1046

    mov.w [w1++], w0
    mov.w w0, 0x1048

    mov.w [w1++], w0
    mov.w w0, 0x104A

    mov.w [w1++], w0
    mov.w w0, 0x104C

    mov.w [w1++], w0
    mov.w w0, 0x104E

    mov.w [w1++], w0
    mov.w w0, 0x1050

    mov.w [w1++], w0
    mov.w w0, 0x1052

    mov.w [w1++], w0
    mov.w w0, 0x1054

    mov.w [w1++], w0
    mov.w w0, 0x1056

    mov.w [w1++], w0
    mov.w w0, 0x1058

    mov.w [w1++], w0
    mov.w w0, 0x105A

    mov.w [w1++], w0
    mov.w w0, 0x105C

    mov.w [w1++], w0
    mov.w w0, 0x105E

    mov.w [w1++], w0
    mov.w w0, 0x1060

    mov.w [w1++], w0
    mov.w w0, 0x1062

    mov.w [w1++], w0
    mov.w w0, 0x1064

    mov.w [w1++], w0
    mov.w w0, 0x1066

    mov.w [w1++], w0
    mov.w w0, 0x1068

    mov.w [w1++], w0
    mov.w w0, 0x106A

    mov.w [w1++], w0
    mov.w w0, 0x106C

    mov.w [w1++], w0
    mov.w w0, 0x106E

    mov.w [w1++], w0
    mov.w w0, 0x1070

    mov.w [w1++], w0
    mov.w w0, 0x1072

    mov.w [w1++], w0
    mov.w w0, 0x1074

    mov.w [w1++], w0
    mov.w w0, 0x1076

    mov.w [w1++], w0
    mov.w w0, 0x1078

    mov.w [w1++], w0
    mov.w w0, 0x107A

    mov.w [w1++], w0
    mov.w w0, 0x107C

    mov.w [w1++], w0
    mov.w w0, 0x107E

    mov.w [w1++], w0
    mov.w w0, 0x1080

    mov.w [w1++], w0
    mov.w w0, 0x1082

    mov.w [w1++], w0
    mov.w w0, 0x1084

    mov.w [w1++], w0
    mov.w w0, 0x1086

    mov.w [w1++], w0
    mov.w w0, 0x1088

    mov.w [w1++], w0
    mov.w w0, 0x108A

    mov.w [w1++], w0
    mov.w w0, 0x108C

    mov.w [w1++], w0
    mov.w w0, 0x108E

    mov.w [w1++], w0
    mov.w w0, 0x1090

    mov.w [w1++], w0
    mov.w w0, 0x1092

    mov.w [w1++], w0
    mov.w w0, 0x1094

    mov.w [w1++], w0
    mov.w w0, 0x1096

    mov.w [w1++], w0
    mov.w w0, 0x1098

    mov.w [w1++], w0
    mov.w w0, 0x109A

    mov.w [w1++], w0
    mov.w w0, 0x109C

    mov.w [w1++], w0
    mov.w w0, 0x109E

    mov.w [w1++], w0
    mov.w w0, 0x10A0

    mov.w [w1++], w0
    mov.w w0, 0x10A2

    mov.w [w1++], w0
    mov.w w0, 0x10A4

    mov.w [w1++], w0
    mov.w w0, 0x10A6

    mov.w [w1++], w0
    mov.w w0, 0x10A8

    mov.w [w1++], w0
    mov.w w0, 0x10AA

    mov.w [w1++], w0
    mov.w w0, 0x10AC

    mov.w [w1++], w0
    mov.w w0, 0x10AE

    mov.w [w1++], w0
    mov.w w0, 0x10B0

    mov.w [w1++], w0
    mov.w w0, 0x10B2

    ; that was 90 * 2 = 180 cycles

    ; if line even, then store screen location
    btss.w w3, #0x0001
    mov.w w1, 0x10F2

    ; compare line number to 480, skip if greater
    mov.w #0x01E0, w1
    mov.w #0x0005, w2 ; 5 cycles
    cpsgt.w w3, w1
    bra w2 ; takes 4 cycles, skip 5 instructions

    ; put old register values back in
    mov.w 0x10F4, w0
    mov.w 0x10F6, w1
    mov.w 0x10F8, w2
    mov.w 0x10FA, w3

    ; return from interrupt, 3 cycles
    retfie

    ; set the periods to interrupt on v-reset

    ; turn off timer1
    bclr.b 0x0105, #0x0007

    ; set prescaler
    mov.w 0x0104, w1
    mov.w #0xFF7F, w0 ; prescaler of 1:8
    and.w w1, w0, w0
    mov.w w0, 0x0104

    ; set period
    mov.w #0x7296, w0 ; (minus one!)
    mov.w w0, 0x0102

    ; clear timer1
    clr.w 0x0100 ; 234686 cycles / 8 = 29335.75 ticks = 0x7297 with 6 NOPs until v-reset

    nop
    nop
    nop
    nop
    nop
    nop ; 6 NOPs to sync everything perfectly

    ; turn on timer1
    bset.b 0x0105, #0x0007 

    ; put old register values back in
    mov.w 0x10F4, w0
    mov.w 0x10F6, w1
    mov.w 0x10F8, w2 
    mov.w 0x10FA, w3 ; takes 4 cycles

    ; return from interrupt, 3 cycles
    retfie


