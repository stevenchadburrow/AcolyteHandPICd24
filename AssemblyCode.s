.section *,address(0x002080),code
.global _assemblyMain
     
_assemblyMain:
    clr.w w0 ; dummy statement
    return
    
    
.section *,address(0x002100),code
.global _drawScanline
    
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
    
    mov.w #0x0010, w0 ; value to turn timer off
    
    mov.w 0x10B4, w2 ; get high sound counter
    inc.w w2, w3 ; increment high sound counter
    mov.w w3, 0x10B4 ; store new high sound counter
    mov.w 0x10B8, w1 ; get high sound duration
    cpslt.w w3, w1 ; if counter greater than duration, skip
    mov.w w0, 0x011E ; turn timer4 off
    
    mov.w 0x10B6, w2 ; get low sound counter
    inc.w w2, w3 ; increment low sound counter
    mov.w w3, 0x10B6 ; store new low sound counter
    mov.w 0x10BA, w1 ; get low sound duration
    cpslt.w w3, w1 ; if counter greater than duration, skip
    mov.w w0, 0x0120 ; turn timer5 off

    mov.w 0x10BE, w2 ; get line number
    inc.w w2, w3 ; increment line number
    mov.w w3, 0x10BE ; store new line number
    mov.w 0x10B2, w1 ; compare with line 480 normally, 0x01E0
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

    mov.w 0x10B2, w0 ; compare with line 480 
    mov.w #0x2000, w1 ; screen location start at 0x2000
    cpsne.w w3, w0 ; if not equal to 400, skip 1 instruction
    mov.w w1, 0x10BC ; clear screen location

    
    ; read only from EDS, not PSV
    push DSRPAG
    push DSWPAG
    
    ; first page of EDS shown from 8000-FFFF
    movpag #0x001, DSRPAG
    movpag #0x001, DSWPAG 
    
    
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
    
  
    ; return paging back to original state 
    pop DSWPAG
    pop DSRPAG 
    

    ; store screen location on even number lines
    mov.w #0x0001, w0
    and.w w0, w3, w2
    cpsne.w w0, w2
    mov.w w1, 0x10BC
    
    movpag #0x200, DSRPAG
    movpag #0x000, DSWPAG 

    ; put old register values back in
    pop.w w3
    pop.w w2
    pop.w w1 
    pop.w w0
    
    ; exit
    return
    


