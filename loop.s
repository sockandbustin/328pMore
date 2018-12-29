


; will light led after 4 button presses, then reset button count 


; this is a simple working program, takes user input from one pin
; and throws it out of another pin 

; the only thing that is "complex" would be the wiring 
; cuz this code is good and works...
; eventually ur gonna wanna know how 2 read & write circuit diagrams tbh. ;) <3

.nolist
.include "m328Pdef.inc"
.list

#device ATmega328P

;==============
; Declarations


 
 .org 0x0000              ; memory (PC) location of reset handler


 
 ;=================
; Start of Program

   rjmp    Init        ; first line executed
   
   ;============
   
   
   
 
   
Init:    
   ser    r16         ; set all bits in temp to 1's.
   ldi r17 , 1 
   ldi r18 , 3 

   out    DDRB,r16    ; setting a bit as 1 on the Data Direction I/O
                       ;  register for PortB, which is DDRB, sets that
                       ;  pin as output, a 0 would set that pin as input
                       ;  so here, all PortB pins are outputs (set to 1)
   ldi r16,0b11111110 ; load the `immediate' number to the temp register
                       ;  if it were just ld then the second argument
                       ;  would have to be a memory location instead
   out    DDRD,r16    ; mv temp to DDRD, result is that PD0 is input
                       ;  and the rest are outputs

   clr    r16         ; all bits in temp are set to 0's
   out    PORTB,r16  ; set all the bits (i.e. pins) in PortB to 0V
   ldi r16,0b00000001 ; load immediate number to temp
   out    PORTD,r16   ; move temp to PortD. PD0 has a pull up resistor 
                       ;  (i.e. set to 5V) since it has a 1 in that bit
                       ;  the rest are 0V since 0's.

                       

                    

Compare:
 cpi r16 , 1
  breq No_Light  
 
cpi r16 , 0

  breq      Math_Test ; Incrementor
  
   rjmp Main
   
   
   ;
   Math_Test:
   ldi r19, 2
   ldi r20, 3 
   ldi r21,  5
   
   add r19 , r20
   cpi r19 , 5   ; turns light on 
    ; cp r19, r21 ;  also turns light on 

    ;cpi   r19, 7     ;  doesn't turn light on
   breq Light
   
   rjmp Main ;
   
   
      

;===============


 No_Light:
           
          
           out    PORTB,r16   ; sends the 0's and 1's read above to PortB
                       ;  this means we want the LED connected to PB0,
                       ;  when PD0 is LOW, it sets PB0 to LOW and turn 
                       ;  on the LED (since the other side of the LED is
                       ;  connected to 5V and this will set PB0 to 0V so 
                       ;  current will flow)
 rjmp Main    ;            
                     
                      ;======================
 Anti_Light: 
 
               ldi    r16, 1     ;
               out    PORTB,r16 ;
               rjmp Main    ;    
                       
Incrementor:

; ldi then register against register cp (compare) works ... 
; so maybe ldi increment result . ? 



; what is k8 ? a register? immediate? 

inc r17;   incrementor doesn't work, is it because ? 
               ; i think because the program loop 
               ; because math comparison works like a dream. 
               ; both with cp and cpi . 
               ; 
;ldi r17 , 3   ; didn't work when non equal was loaded.  

cpi r17, 3  ;
breq Light    ; was branching to Anti_Light

;cp r17,  r18     ; compare with 3
  ; brne Anti_Light  


rjmp Main
;===============

Light:

ldi r16, 0 ; 
out  PORTB, r16;

;out    PORTB,r16   ; sends the 0's and 1's read above to PortB
                       ;  this means we want the LED connected to PB0,
                       ;  when PD0 is LOW, it sets PB0 to LOW and turn 
                       ;  on the LED (since the other side of the LED is
                       ;  connected to 5V and this will set PB0 to 0V so 
                       ;  current will flow)
 rjmp Main    ;
 
 


; Main body of program:  ====================
Main:
   in    r16,PIND     ; PinD holds the state of PortD, copy this to temp
                       ;  if the button is connected to PD0 this will be
                       ;  0 when the button is pushed, 1 otherwise since
                       ;  PD0 has a pull up resistor it's normally at 5V
   
   rcall   Compare         
  ;  rcall	Test  
  ; rcall Retest ;          
   rjmp    Main        ; loops back to the start of Main