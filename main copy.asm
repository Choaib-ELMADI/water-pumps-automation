list p=16f877a
include "p16f877a.inc"

; RB0, RB1, RB2 ===> inputs  for b1, b2, b3
; RB5, RB6, RB7 ===> inputs  for h1, h2, h3
; RA0, RA1, RA2 ===> outputs for P1, P2, P3

if RB0 === 1 activate P1 only
if RB1 === 1 activate P1 et P2 only
if RB2 === 1 activate P1 et P2 et P3 only

if RB7 === 0 desactivate P3
if RB6 === 0 desactivate P2
if RB5 === 0 desactivate P1

INIT
    bsf STATUS, 5       ; set
    bcf STATUS, 6       ; clear
    clrf TRISA          ; output
    movlw b'11111111'
    movwf TRISB         ; input
    bcf STATUS, 5
    ; movlw b'11100000'
    ; movwf PORTB
    movlw b'00000000'
    movwf PORTA

MAIN
    btfsc PORTB, 0      ; si RB0 === 1 on active P1
    movlw b'00000001'
    movwf PORTA         ; Pompe P1 activée

    btfss PORTB, 5      ; si RB5 === 0 on désactive tous
    movlw b'00000000'
    movwf PORTA         ; Arret de tous les pompes

    goto MAIN
    
end
