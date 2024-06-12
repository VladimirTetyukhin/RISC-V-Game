# licensed under Creative Commons Attribution International license 4.0

    .text
    .globl readstartbutton
    
readstartbutton:
    li t0,0xffff0010   
    lw a0, 0(t0)  
              
    jr ra               # return 
    
