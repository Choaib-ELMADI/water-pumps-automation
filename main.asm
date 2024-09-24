list p=16f877a
include "p16f877a.inc"

; RB0 ===> input for b3 (bottom sensor, no water = 1)
; RB1 ===> input for b2 (mid sensor, no water = 1)
; RB2 ===> input for b1 (top sensor, no water = 1)
; RB5 ===> input for h3 (top sensor, no water = 1)
; RB6 ===> input for h2 (mid sensor, no water = 1)
; RB7 ===> input for h1 (bottom sensor, no water = 1)
; RA0 ===> output for P1
; RA1 ===> output for P2
; RA2 ===> output for P3

INIT
    bsf STATUS, 5        ; select Bank 1
    clrf TRISA           ; set PORTA as output
    movlw b'11111111'    
    movwf TRISB          ; set PORTB as input
    bcf STATUS, 5        ; return to Bank 0
    clrf PORTA           ; initialize PORTA (all outputs off)

MAIN
    ; Pump 1 Control
    btfss PORTB, 2       ; Check if b1 (RB2) is 0 (water present)
    goto CHECK_H1        ; If b1 is 1 (no water), check h1 (RB7)
    goto P1_OFF          ; If b1 is 0, P1 is off

CHECK_H1
    btfss PORTB, 7       ; Check if h1 (RB7) is 0 (water present)
    goto P1_ON           ; If h1 is 1 (no water), turn on P1
    goto P1_OFF          ; If h1 is 0, P1 is off

P1_ON
    bsf PORTA, 0         ; Turn on P1
    goto CHECK_P2        ; Move to next pump check

P1_OFF
    bcf PORTA, 0         ; Turn off P1
    goto CHECK_P2        ; Move to next pump check

; Pump 2 Control
CHECK_P2
    btfss PORTB, 1       ; Check if b2 (RB1) is 0 (water present)
    goto CHECK_H2        ; If b2 is 1 (no water), check h2 (RB6)
    goto P2_OFF          ; If b2 is 0, P2 is off

CHECK_H2
    btfss PORTB, 6       ; Check if h2 (RB6) is 0 (water present)
    goto P2_ON           ; If h2 is 1 (no water), turn on P2
    goto P2_OFF          ; If h2 is 0, P2 is off

P2_ON
    bsf PORTA, 1         ; Turn on P2
    goto CHECK_P3        ; Move to next pump check

P2_OFF
    bcf PORTA, 1         ; Turn off P2
    goto CHECK_P3        ; Move to next pump check

; Pump 3 Control
CHECK_P3
    btfss PORTB, 0       ; Check if b3 (RB0) is 0 (water present)
    goto CHECK_H3        ; If b3 is 1 (no water), check h3 (RB5)
    goto P3_OFF          ; If b3 is 0, P3 is off

CHECK_H3
    btfss PORTB, 5       ; Check if h3 (RB5) is 0 (water present)
    goto P3_ON           ; If h3 is 1 (no water), turn on P3
    goto P3_OFF          ; If h3 is 0, P3 is off

P3_ON
    bsf PORTA, 2         ; Turn on P3
    goto MAIN            ; Repeat the main loop

P3_OFF
    bcf PORTA, 2         ; Turn off P3
    goto MAIN            ; Repeat the main loop

end
