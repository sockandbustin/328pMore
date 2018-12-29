

.nolist
.include "m328Pdef.inc"
.list

#device ATmega328P

;==============
; Declarations:




.org 0x0000              ; memory (PC) location of reset handler


;============


blink:
  
   
   
rcall Rain_Maker


 
   
   
   Rain_Maker:

sbi PORTD, 4          ; turn off LED on PD4

clr r16

counter1:

inc r16

clr r1;

cpi r16 , 100

brne counter1

clr r16 



counter2:

inc r17


cpi r17, 100

brne counter1

clr r17


counter3:

inc r18 

cpi r18 , 25

brne counter2 

clr r18


;======================

Light_OFF:
 cbi PORTD, 4 
 

clr r16

counter4:

inc r16

clr r1;

cpi r16 , 100

brne counter4

clr r16 



counter5:

inc r17


cpi r17, 100

brne counter4

clr r17


counter6:

inc r18

cpi r18 , 25

brne counter5 

clr r18 
 

ret


; 100*100*100 = 1mill which equals 4 seconds, 
; 4mhz clock SO    250k should equal exactly 1 second 
;---------------------



   
   
   
   
   
   
   




; this is a way to use "prescalers" to time even larger tiem frames
; ex seconds  minutes hours , instead of nanoseconds, also gets into pulse-width modulation 
;http://www.avrbeginners.net/architecture/timers/timers.html

