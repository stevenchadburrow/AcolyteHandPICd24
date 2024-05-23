.global _assemblyMain
.global _drawScanline 
.global _NTSC


_assemblyMain:
    clr.w w0 ; dummy statement
    return
    
    
_drawScanline:
    ; store registers for later
    push.w w0
    push.w w1
    push.w w2
    push.w w3

    ; clear timer1 interrupt flag
    mov.w 0x0800, w0
    mov.w #0xFFF7, w1
    and.w w0, w1, w0
    mov.w w0, 0x0800

    mov.w 0x10BE, w2 ; get line number
    inc.w w2, w3 ; increment line number
    mov.w w3, 0x10BE ; store new line number
    mov.w #0x01E0, w1 ; compare with line 480, 0x01E0
    cpsgt.w w3, w1 ; if greater than 480, skip 1 instruction
    goto drawScanlineColors ; 2 cycles

    mov.w #0x0274, w1 ; compare with line 628
    cpsne.w w3, w1 ; if not equal to 628, skip 1 instruction
    clr.w 0x10BE ; clear line number

    ; put old register values back in
    pop.w w3
    pop.w w2
    pop.w w1 
    pop.w w0

    ; exit
    return
    
drawScanlineColors:
    ; needed for color anding
    mov.w #0xF000, w2

    ; race the beam for 80 words, thus 320 pixels, 12 cycles each word
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

    ; turn pixels off
    clr.w 0x0E14

    mov.w #0x01E0, w0 ; compare with line 480 
    mov.w #0x2000, w1 ; screen location start
    cpsne.w w3, w0 ; if not equal to 400, skip 1 instruction
    mov.w w1, 0x10BC ; clear screen location

    ; grab screen location
    mov.w 0x10BC, w1

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

    ; store screen location on even number lines
    mov.w #0x0001, w0
    and.w w0, w3, w2
    cpsne.w w0, w2
    mov.w w1, 0x10BC

    ; put old register values back in
    pop.w w3
    pop.w w2
    pop.w w1 
    pop.w w0
    
    ; exit
    return
    

; needs a LOT of testing!
_NTSC:
    mov.w #0xFCFB, w0
    mov.w TRISC, w1
    and.w w0, w1, w2
    mov.w w2, TRISC
NTSCBigLoop:    
    call NTSCLineOne
    call NTSCLineOne
    call NTSCLineOne
    call NTSCLineFour
    call NTSCLineFour
    call NTSCLineFour
    call NTSCLineOne
    call NTSCLineOne
    call NTSCLineOne
    call NTSCLineTen
    call NTSCLineTen
    call NTSCLineTen
    call NTSCLineTen
    call NTSCLineTen
    call NTSCLineTen
    call NTSCLineTen
    call NTSCLineTen
    call NTSCLineTen
    call NTSCLineTen
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineTwenty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    call NTSCLineThirty
    
    call NTSCLineLast
    goto NTSCBigLoop
    
    
    
    
; 2 cycles to use call
NTSCLineOne:
    clr.w PORTC
    mov.w #46, w0
NTSCLineOneLoopOne:
    dec.w w0, w0
    bra nz, NTSCLineOneLoopOne
    mov.w #0x0004, w0
    mov.w w0, PORTC
    mov.w #589, w0
NTSCLineOneLoopTwo:
    dec.w w0, w0
    bra nz, NTSCLineOneLoopTwo
    nop
    clr.w PORTC
    mov.w #46, w0
NTSCLineOneLoopThree:
    dec.w w0, w0
    bra nz, NTSCLineOneLoopThree
    mov.w #0x0004, w0
    mov.w w0, PORTC
    mov.w #587, w0
NTSCLineOneLoopFour:
    dec.w w0, w0
    bra nz, NTSCLineOneLoopFour
    nop
    nop
    return ; 3 cycles to return
    
; 2 cycles to call
NTSCLineFour:
    clr.w PORTC
    mov.w #541, w0
NTSCLineFourLoopOne:
    dec.w w0, w0
    bra nz, NTSCLineFourLoopOne
    mov.w #0x0004, w0
    mov.w w0, PORTC
    mov.w #94, w0
NTSCLineFourLoopTwo:
    dec.w w0, w0
    bra nz, NTSCLineFourLoopTwo
    nop
    clr.w PORTC
    mov.w #541, w0
NTSCLineFourLoopThree:
    dec.w w0, w0
    bra nz, NTSCLineFourLoopThree
    mov.w #0x0004, w0
    mov.w w0, PORTC
    mov.w 92, w0
NTSCLineFourLoopFour:
    dec.w w0, w0
    bra nz, NTSCLineFourLoopFour
    nop
    nop
    return ; 3 cycles to return
  
; 2 cycles to call
NTSCLineTen:
    clr.w PORTC
    mov.w #94, w0
NTSCLineTenLoopOne:
    dec.w w0, w0
    bra nz, NTSCLineTenLoopOne
    mov.w #0x0004, w0
    mov.w w0, PORTC
    mov.w #1174, w0
NTSCLineTenLoopTwo:
    dec.w w0, w0
    bra nz, NTSCLineTenLoopTwo
    nop
    nop
    return ; 3 cycels to return
    
; 2 cycles to call
NTSCLineTwenty:
    clr.w PORTC
    mov.w 94, w0
NTSCLineTwentyLoopOne:
    dec.w w0, w0
    bra nz, NTSCLineTwentyLoopOne
    mov.w #0x0004, w0
    mov.w w0, PORTC
    mov.w #94, w0
NTSCLineTwentyLoopTwo:
    dec.w w0, w0
    bra nz, NTSCLineTwentyLoopTwo
    
    mov.w #0x0304, w0 ; visible
    mov.w w0, PORTC
    mov.w #1052, w0
NTSCLineTwentyLoopThree:
    dec.w w0, w0
    bra nz, NTSCLineTwentyLoopThree
    
    mov.w #0x0004, w0
    mov.w w0, PORTC
    mov.w #28, w0
NTSCLineTwentyLoopFour:
    dec.w w0, w0
    bra nz, NTSCLineTwentyLoopFour
    nop
    nop
    return ; 3 cycles to return
    
; 2 cycles to call
NTSCLineThirty:
    clr.w PORTC
    mov.w #94, w0
NTSCLineThirtyLoopOne:
    dec.w w0, w0
    bra nz, NTSCLineThirtyLoopOne
    mov.w #0x0004, w0
    mov.w w0, PORTC
    mov.w #94, w0
NTSCLineThirtyLoopTwo:
    dec.w w0, w0
    bra nz, NTSCLineThirtyLoopTwo
    
    mov.w #0x0204, w0 ; visible
    mov.w w0, PORTC
    mov.w #1052, w0
NTSCLineThirtyLoopThree:
    dec.w w0, w0
    bra nz, NTSCLineThirtyLoopThree
    
    mov.w #0x0004, w0
    mov.w w0, PORTC
    mov.w #28, w0
NTSCLineThirtyLoopFour:
    dec.w w0, w0
    bra nz, NTSCLineThirtyLoopFour
    nop
    nop
    return ; 3 cycles to return
    
    
; 2 cycles to call
NTSCLineLast:
    clr.w PORTC
    mov.w #94, w0
NTSCLineLastLoopOne:
    dec.w w0, w0
    bra nz, NTSCLineLastLoopOne
    mov.w #0x0004, w0
    mov.w w0, PORTC
    mov.w #1174, w0
NTSCLineLastLoopTwo:
    dec.w w0, w0
    bra nz, NTSCLineLastLoopTwo
    return ; 3 cycles to return
    ; and 2 more cycles to goto again
    
    