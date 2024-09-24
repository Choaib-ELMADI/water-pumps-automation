list p=16f877a
include "p16f877a.inc"

; RB0, RB1, RB2 ===> inputs  for b1, b2, b3
; RB5, RB6, RB7 ===> inputs  for h1, h2, h3
; RA0, RA1, RA2 ===> outputs for P1, P2, P3

INIT
    bsf STATUS, 5       ; set
    bcf STATUS, 6       ; clear
    clrf TRISA          ; output
    movlw b'11111111'
    movwf TRISB         ; input
    bcf STATUS, 5
    movlw b'00000000'
    movwf PORTA

MAIN
    btfss PORTB, 0
    goto RIEN_ACTIVE

P1_ACTIVE
    movlw b'00000001'
    movwf PORTA
    btfss PORTB, 1
    goto P1_ACTIVE

P2_ACTIVE
    movlw b'00000011'
    movwf PORTA
    btfss PORTB, 2
    goto P2_ACTIVE

P3_ACTIVE
    movlw b'00000111'
    movwf PORTA
    goto P3_ACTIVE

RIEN_ACTIVE
    movlw b'00000000'
    movwf PORTA
    goto MAIN
    
end
