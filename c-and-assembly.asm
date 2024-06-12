
c-and-assembly:     file format elf64-littleriscv


Disassembly of section .init:

0000000080000000 <_start>:
    .extern __stack_init      # address of the initial top of C call stack (calculated externally 
                              # by linker)

	.globl _start
_start:                       # this is where CPU starts executing instructions after reset / power-on
	la sp,__stack_init        # initialise sp (with the value that points to the last word of RAM)
    80000000:	00001117          	auipc	sp,0x1
    80000004:	78010113          	addi	sp,sp,1920 # 80001780 <__stack_init>
	li a0,0                   # populate optional main() parameters with dummy values (just in case)
    80000008:	00000513          	li	a0,0
	li a1,0
    8000000c:	00000593          	li	a1,0
	li a2,0
    80000010:	00000613          	li	a2,0
	jal main                  # call C main() function
    80000014:	008000ef          	jal	ra,8000001c <main>

0000000080000018 <exit>:
exit:
	j exit                    # keep looping forever after main() returns
    80000018:	0000006f          	j	80000018 <exit>

Disassembly of section .text:

000000008000001c <main>:
 */
 
 #include "lib.h" 

int main() 
{ 
    8000001c:	f0010113          	addi	sp,sp,-256
    80000020:	0e113c23          	sd	ra,248(sp)
    80000024:	0e813823          	sd	s0,240(sp)
    80000028:	0e913423          	sd	s1,232(sp)
    8000002c:	0f213023          	sd	s2,224(sp)
    80000030:	0d313c23          	sd	s3,216(sp)
    80000034:	0d413823          	sd	s4,208(sp)
    80000038:	0d513423          	sd	s5,200(sp)
    8000003c:	0d613023          	sd	s6,192(sp)
    80000040:	0b713c23          	sd	s7,184(sp)
    80000044:	0b813823          	sd	s8,176(sp)
    80000048:	0b913423          	sd	s9,168(sp)
    8000004c:	0ba13023          	sd	s10,160(sp)
    80000050:	09b13c23          	sd	s11,152(sp)
    int score = 0;
    int slider = 0;
    
    int board[32]; // Array to represent the game board
    // Initializing board
    for (int i = 0; i < 32; ++i){
    80000054:	01010793          	addi	a5,sp,16
    80000058:	09010713          	addi	a4,sp,144
        board[i] = 0;
    8000005c:	0007a023          	sw	zero,0(a5)
    for (int i = 0; i < 32; ++i){
    80000060:	00478793          	addi	a5,a5,4
    80000064:	fee79ce3          	bne	a5,a4,8000005c <main+0x40>
    }
    board[16] = -1; // Setting a brick in the middle of the board
    80000068:	fff00793          	li	a5,-1
    8000006c:	04f12823          	sw	a5,80(sp)

    printstr("*** BREAKOUT! ***\n\n");
    80000070:	00000517          	auipc	a0,0x0
    80000074:	54050513          	addi	a0,a0,1344 # 800005b0 <readstartbutton+0x18>
    80000078:	25c000ef          	jal	ra,800002d4 <printstr>
    
    // Platform-specific setup
    #ifdef QEMU20180
    	slider = 0;
    	printstr("Press any key on the MMIO Keyboard to start\n");
    8000007c:	00000517          	auipc	a0,0x0
    80000080:	54c50513          	addi	a0,a0,1356 # 800005c8 <readstartbutton+0x30>
    80000084:	250000ef          	jal	ra,800002d4 <printstr>
    	
    	while ((pollkbd() & RDR_READY_BIT) == 0) {} // Wait for key press
    80000088:	3cc000ef          	jal	ra,80000454 <pollkbd>
    8000008c:	00157793          	andi	a5,a0,1
    80000090:	fe078ce3          	beqz	a5,80000088 <main+0x6c>
    	
    	slider = 27;
    	printstr("Control keys: a - move paddle left; d - move paddle right\n");
    80000094:	00000517          	auipc	a0,0x0
    80000098:	56450513          	addi	a0,a0,1380 # 800005f8 <readstartbutton+0x60>
    8000009c:	238000ef          	jal	ra,800002d4 <printstr>
    	slider = 27;
    800000a0:	01b00b93          	li	s7,27
    int score = 0;
    800000a4:	00000b13          	li	s6,0
    int dy = -1;
    800000a8:	fff00c93          	li	s9,-1
    int dx = -1;
    800000ac:	fff00a93          	li	s5,-1
    int ballY = 30;
    800000b0:	01e00a13          	li	s4,30
    int ballX = 29;
    800000b4:	01d00993          	li	s3,29
    
    // Main game loop
    while(score >= 0 && score < 32){
        #ifdef QEMU20180
        	int k = readchar();
        	if(k == 'a' && slider < 27) ++slider; // Move paddle left
    800000b8:	06100d93          	li	s11,97
    int ballX = 29;
    800000bc:	01c9c7b7          	lui	a5,0x1c9c
    800000c0:	38078793          	addi	a5,a5,896 # 1c9c380 <_start-0x7e363c80>
    800000c4:	00f13423          	sd	a5,8(sp)
        	slider = readslider(); // Read slider position
        #endif
        printscore(score); // Print current score
        
        // Update board with ball and slider positions
        board[ballY] |= (1 << ballX);
    800000c8:	00100d13          	li	s10,1
    800000cc:	0ac0006f          	j	80000178 <main+0x15c>
        	if(k == 'a' && slider < 27) ++slider; // Move paddle left
    800000d0:	01a00793          	li	a5,26
    800000d4:	0177c863          	blt	a5,s7,800000e4 <main+0xc8>
    800000d8:	001b8b9b          	addiw	s7,s7,1
    800000dc:	0080006f          	j	800000e4 <main+0xc8>
        	if(k == 'd' && slider > 0) --slider; // Move paddle right
    800000e0:	fffb8b9b          	addiw	s7,s7,-1
    int ballX = 29;
    800000e4:	00813783          	ld	a5,8(sp)
        	for(int i = 0; i < 30000000; ++i){} // Delay for simulation purposes
    800000e8:	fff7879b          	addiw	a5,a5,-1
    800000ec:	fe079ee3          	bnez	a5,800000e8 <main+0xcc>
        printscore(score); // Print current score
    800000f0:	000b0513          	mv	a0,s6
    800000f4:	274000ef          	jal	ra,80000368 <printscore>
        board[ballY] |= (1 << ballX);
    800000f8:	013d14bb          	sllw	s1,s10,s3
    800000fc:	00048c1b          	sext.w	s8,s1
    80000100:	002a1913          	slli	s2,s4,0x2
    80000104:	09010793          	addi	a5,sp,144
    80000108:	01278933          	add	s2,a5,s2
    8000010c:	f8092783          	lw	a5,-128(s2)
    80000110:	00fc67b3          	or	a5,s8,a5
    80000114:	f8f92023          	sw	a5,-128(s2)
        board[31] |= (0b11111 << slider);
    80000118:	01f00793          	li	a5,31
    8000011c:	0177943b          	sllw	s0,a5,s7
    80000120:	08c12783          	lw	a5,140(sp)
    80000124:	00f467b3          	or	a5,s0,a5
    80000128:	08f12623          	sw	a5,140(sp)
        
        showpic(board); // Display current game state
    8000012c:	01010513          	addi	a0,sp,16
    80000130:	43c000ef          	jal	ra,8000056c <showpic>
        
        // Clear previous ball and slider positions
        board[ballY] &= ~(1 << ballX); 
    80000134:	fff4c793          	not	a5,s1
    80000138:	0007879b          	sext.w	a5,a5
    8000013c:	f8092703          	lw	a4,-128(s2)
    80000140:	00e7f733          	and	a4,a5,a4
    80000144:	f8e92023          	sw	a4,-128(s2)
        board[31] &= ~(0b11111 << slider);
    80000148:	fff44713          	not	a4,s0
    8000014c:	08c12683          	lw	a3,140(sp)
    80000150:	00d77733          	and	a4,a4,a3
    80000154:	08e12623          	sw	a4,140(sp)
        
        // Ball movement and collision detection logic
        
        if(ballX == 0 || ballX == 32){ // Left and right borders
    80000158:	fdf9f713          	andi	a4,s3,-33
    8000015c:	02071a63          	bnez	a4,80000190 <main+0x174>
            dx = -dx; 
    80000160:	41500abb          	negw	s5,s5
        else if(ballY == 32){
            score = -1; // Ball reached bottom, game over
        }
        
        // Update ball position
        ballX += dx;
    80000164:	013a89bb          	addw	s3,s5,s3
        ballY += dy;
    80000168:	014c8a3b          	addw	s4,s9,s4
    while(score >= 0 && score < 32){
    8000016c:	000b079b          	sext.w	a5,s6
    80000170:	01f00713          	li	a4,31
    80000174:	0af76263          	bltu	a4,a5,80000218 <main+0x1fc>
        	int k = readchar();
    80000178:	2ec000ef          	jal	ra,80000464 <readchar>
        	if(k == 'a' && slider < 27) ++slider; // Move paddle left
    8000017c:	f5b50ae3          	beq	a0,s11,800000d0 <main+0xb4>
        	if(k == 'd' && slider > 0) --slider; // Move paddle right
    80000180:	06400793          	li	a5,100
    80000184:	f6f510e3          	bne	a0,a5,800000e4 <main+0xc8>
    80000188:	f5704ce3          	bgtz	s7,800000e0 <main+0xc4>
    8000018c:	f59ff06f          	j	800000e4 <main+0xc8>
        else if(ballY + dy == 16 && board[16] && (1 << ballX)){ //Hitting the brick wall from up or down
    80000190:	019a073b          	addw	a4,s4,s9
    80000194:	01000693          	li	a3,16
    80000198:	00d70c63          	beq	a4,a3,800001b0 <main+0x194>
        else if(ballY == 16 && board[16] && (1 << (ballX + dx))){ //Hitting the brick wall from left or right
    8000019c:	01000793          	li	a5,16
    800001a0:	02fa0863          	beq	s4,a5,800001d0 <main+0x1b4>
        else if(ballY + dy == 0){ //Hitting the upper border
    800001a4:	04071c63          	bnez	a4,800001fc <main+0x1e0>
            dy = -dy; 
    800001a8:	41900cbb          	negw	s9,s9
    800001ac:	fb9ff06f          	j	80000164 <main+0x148>
        else if(ballY + dy == 16 && board[16] && (1 << ballX)){ //Hitting the brick wall from up or down
    800001b0:	05012683          	lw	a3,80(sp)
    800001b4:	0e068063          	beqz	a3,80000294 <main+0x278>
    800001b8:	0c0c0263          	beqz	s8,8000027c <main+0x260>
            board[16] &= ~(1 << ballX);
    800001bc:	00d7f7b3          	and	a5,a5,a3
    800001c0:	04f12823          	sw	a5,80(sp)
            ++score;
    800001c4:	001b0b1b          	addiw	s6,s6,1
            dy = -dy; 
    800001c8:	41900cbb          	negw	s9,s9
    800001cc:	f99ff06f          	j	80000164 <main+0x148>
        else if(ballY == 16 && board[16] && (1 << (ballX + dx))){ //Hitting the brick wall from left or right
    800001d0:	05012683          	lw	a3,80(sp)
    800001d4:	fc0688e3          	beqz	a3,800001a4 <main+0x188>
    800001d8:	015987bb          	addw	a5,s3,s5
    800001dc:	00fd17bb          	sllw	a5,s10,a5
    800001e0:	fc0782e3          	beqz	a5,800001a4 <main+0x188>
            board[16] &= ~(1 << (ballX + dx));
    800001e4:	fff7c793          	not	a5,a5
    800001e8:	00f6f7b3          	and	a5,a3,a5
    800001ec:	04f12823          	sw	a5,80(sp)
            ++score;
    800001f0:	001b0b1b          	addiw	s6,s6,1
            dx = -dx; 
    800001f4:	41500abb          	negw	s5,s5
    800001f8:	f6dff06f          	j	80000164 <main+0x148>
        else if(ballY + dy == 31){
    800001fc:	01f00793          	li	a5,31
    80000200:	08f71e63          	bne	a4,a5,8000029c <main+0x280>
            if (ballX <= slider + 4 && ballX >= slider){
    80000204:	004b879b          	addiw	a5,s7,4
    80000208:	f537cee3          	blt	a5,s3,80000164 <main+0x148>
    8000020c:	f579cce3          	blt	s3,s7,80000164 <main+0x148>
                dy = -dy; 
    80000210:	41900cbb          	negw	s9,s9
    80000214:	f51ff06f          	j	80000164 <main+0x148>
    }
    
    // Game end conditions
    if(score == 32) {
    80000218:	02000793          	li	a5,32
    8000021c:	04fb0863          	beq	s6,a5,8000026c <main+0x250>
        printstr("YOU WON!\n");
    }
    printstr("Game over\n");
    80000220:	00000517          	auipc	a0,0x0
    80000224:	42850513          	addi	a0,a0,1064 # 80000648 <readstartbutton+0xb0>
    80000228:	0ac000ef          	jal	ra,800002d4 <printstr>
    
    return 0; // Return 0 to indicate successful execution
}
    8000022c:	00000513          	li	a0,0
    80000230:	0f813083          	ld	ra,248(sp)
    80000234:	0f013403          	ld	s0,240(sp)
    80000238:	0e813483          	ld	s1,232(sp)
    8000023c:	0e013903          	ld	s2,224(sp)
    80000240:	0d813983          	ld	s3,216(sp)
    80000244:	0d013a03          	ld	s4,208(sp)
    80000248:	0c813a83          	ld	s5,200(sp)
    8000024c:	0c013b03          	ld	s6,192(sp)
    80000250:	0b813b83          	ld	s7,184(sp)
    80000254:	0b013c03          	ld	s8,176(sp)
    80000258:	0a813c83          	ld	s9,168(sp)
    8000025c:	0a013d03          	ld	s10,160(sp)
    80000260:	09813d83          	ld	s11,152(sp)
    80000264:	10010113          	addi	sp,sp,256
    80000268:	00008067          	ret
        printstr("YOU WON!\n");
    8000026c:	00000517          	auipc	a0,0x0
    80000270:	3cc50513          	addi	a0,a0,972 # 80000638 <readstartbutton+0xa0>
    80000274:	060000ef          	jal	ra,800002d4 <printstr>
    80000278:	fa9ff06f          	j	80000220 <main+0x204>
        else if(ballY == 16 && board[16] && (1 << (ballX + dx))){ //Hitting the brick wall from left or right
    8000027c:	01000793          	li	a5,16
    80000280:	00fa1e63          	bne	s4,a5,8000029c <main+0x280>
    80000284:	015987bb          	addw	a5,s3,s5
    80000288:	00fd17bb          	sllw	a5,s10,a5
    8000028c:	f4079ce3          	bnez	a5,800001e4 <main+0x1c8>
    80000290:	ed5ff06f          	j	80000164 <main+0x148>
    80000294:	01000793          	li	a5,16
    80000298:	ecfa06e3          	beq	s4,a5,80000164 <main+0x148>
        else if(ballY == 32){
    8000029c:	02000793          	li	a5,32
    800002a0:	ecfa12e3          	bne	s4,a5,80000164 <main+0x148>
    800002a4:	f7dff06f          	j	80000220 <main+0x204>

00000000800002a8 <abs>:
 */

#include "lib.h"

// returns absolute value of its integer argument - a replacement of the standard library function abs() 
inline int abs(int n) { return (n < 0) ? (-n) : n; }
    800002a8:	41f5579b          	sraiw	a5,a0,0x1f
    800002ac:	00f54533          	xor	a0,a0,a5
    800002b0:	40f5053b          	subw	a0,a0,a5
    800002b4:	00008067          	ret

00000000800002b8 <printchar>:

// prints single character to console - a substitute for the standard library funciton putch(int chr)
inline void printchar(char chr) { *(TDR) = chr; }  // write into TDR 
    800002b8:	100007b7          	lui	a5,0x10000
    800002bc:	00a78023          	sb	a0,0(a5) # 10000000 <_start-0x70000000>
    800002c0:	00008067          	ret

00000000800002c4 <println>:
    800002c4:	100007b7          	lui	a5,0x10000
    800002c8:	00a00713          	li	a4,10
    800002cc:	00e78023          	sb	a4,0(a5) # 10000000 <_start-0x70000000>

// prints newline character to console
void println() { printchar('\n'); }
    800002d0:	00008067          	ret

00000000800002d4 <printstr>:

// prints given string of characters to console - a substitute for the standard library function puts(char *s)
void printstr(char *str)
{
    while (*str != '\0') 
    800002d4:	00054783          	lbu	a5,0(a0)
    800002d8:	00078c63          	beqz	a5,800002f0 <printstr+0x1c>
inline void printchar(char chr) { *(TDR) = chr; }  // write into TDR 
    800002dc:	10000737          	lui	a4,0x10000
    800002e0:	00f70023          	sb	a5,0(a4) # 10000000 <_start-0x70000000>
    {
        printchar(*str);
        str += 1;
    800002e4:	00150513          	addi	a0,a0,1
    while (*str != '\0') 
    800002e8:	00054783          	lbu	a5,0(a0)
    800002ec:	fe079ae3          	bnez	a5,800002e0 <printstr+0xc>
    }
}
    800002f0:	00008067          	ret

00000000800002f4 <convertsevensegment>:


int convertsevensegment(int n) {
    switch(n) {
    800002f4:	00900793          	li	a5,9
    800002f8:	06a7e063          	bltu	a5,a0,80000358 <convertsevensegment+0x64>
    800002fc:	00251713          	slli	a4,a0,0x2
    80000300:	00000697          	auipc	a3,0x0
    80000304:	35468693          	addi	a3,a3,852 # 80000654 <readstartbutton+0xbc>
    80000308:	00d70733          	add	a4,a4,a3
    8000030c:	00072783          	lw	a5,0(a4)
    80000310:	00d787b3          	add	a5,a5,a3
    80000314:	00078067          	jr	a5
        case 7:
            return 0b00000111;
        case 8:
            return 0b01111111;
        case 9:
            return 0b01101111;
    80000318:	00600513          	li	a0,6
    8000031c:	00008067          	ret
            return 0b01011011;
    80000320:	05b00513          	li	a0,91
    80000324:	00008067          	ret
            return 0b01001111;
    80000328:	04f00513          	li	a0,79
    8000032c:	00008067          	ret
            return 0b01100110;
    80000330:	06600513          	li	a0,102
    80000334:	00008067          	ret
            return 0b01101101;
    80000338:	06d00513          	li	a0,109
    8000033c:	00008067          	ret
            return 0b01111101;
    80000340:	07d00513          	li	a0,125
    80000344:	00008067          	ret
            return 0b01111111;
    80000348:	07f00513          	li	a0,127
    8000034c:	00008067          	ret
            return 0b01101111;
    80000350:	06f00513          	li	a0,111
    80000354:	00008067          	ret
        default:
            return 0;
    80000358:	00000513          	li	a0,0
    8000035c:	00008067          	ret
            return 0b00111111;
    80000360:	03f00513          	li	a0,63
    }
}
    80000364:	00008067          	ret

0000000080000368 <printscore>:

void printscore(int n){
    80000368:	fe010113          	addi	sp,sp,-32
    8000036c:	00113c23          	sd	ra,24(sp)
    80000370:	00813823          	sd	s0,16(sp)
    80000374:	00913423          	sd	s1,8(sp)
    80000378:	01213023          	sd	s2,0(sp)
    8000037c:	00050493          	mv	s1,a0
	*(SCR) = (convertsevensegment(n / 10) << 8) + convertsevensegment(n % 10);
    80000380:	00a00913          	li	s2,10
    80000384:	0325453b          	divw	a0,a0,s2
    80000388:	f6dff0ef          	jal	ra,800002f4 <convertsevensegment>
    8000038c:	00050413          	mv	s0,a0
    80000390:	0324e53b          	remw	a0,s1,s2
    80000394:	f61ff0ef          	jal	ra,800002f4 <convertsevensegment>
    80000398:	0084141b          	slliw	s0,s0,0x8
    8000039c:	00a4043b          	addw	s0,s0,a0
    800003a0:	0ffff7b7          	lui	a5,0xffff
    800003a4:	00479793          	slli	a5,a5,0x4
    800003a8:	0087a823          	sw	s0,16(a5) # ffff010 <_start-0x70000ff0>
}
    800003ac:	01813083          	ld	ra,24(sp)
    800003b0:	01013403          	ld	s0,16(sp)
    800003b4:	00813483          	ld	s1,8(sp)
    800003b8:	00013903          	ld	s2,0(sp)
    800003bc:	02010113          	addi	sp,sp,32
    800003c0:	00008067          	ret

00000000800003c4 <printint>:

// prints given integer as a signed decimal number
void printint(int n)
{
    800003c4:	ff010113          	addi	sp,sp,-16
    {
        sign = '-';
    }
    else
    {
        sign = '\0';
    800003c8:	43f55813          	srai	a6,a0,0x3f
    800003cc:	02d87813          	andi	a6,a6,45
    800003d0:	00010713          	mv	a4,sp
    800003d4:	00900613          	li	a2,9
    
    // produce decimal digits of the number going from right to left, keep them in num[] array.
    do 
    {
        i = i - 1;
        num[i] = abs(n % 10) + '0';
    800003d8:	00a00593          	li	a1,10
        i = i - 1;
    800003dc:	fff6061b          	addiw	a2,a2,-1
        num[i] = abs(n % 10) + '0';
    800003e0:	02b567bb          	remw	a5,a0,a1
    800003e4:	41f7d69b          	sraiw	a3,a5,0x1f
    800003e8:	00f6c7b3          	xor	a5,a3,a5
    800003ec:	40d787bb          	subw	a5,a5,a3
    800003f0:	0307879b          	addiw	a5,a5,48
    800003f4:	00f70423          	sb	a5,8(a4)
        n = n / 10;
    800003f8:	02b5453b          	divw	a0,a0,a1
    } while (n != 0);
    800003fc:	fff70713          	addi	a4,a4,-1
    80000400:	fc051ee3          	bnez	a0,800003dc <printint+0x18>
    
    //now print the sign of the number and its digits left-to-right.
    if (sign) 
    80000404:	00080663          	beqz	a6,80000410 <printint+0x4c>
inline void printchar(char chr) { *(TDR) = chr; }  // write into TDR 
    80000408:	100007b7          	lui	a5,0x10000
    8000040c:	01078023          	sb	a6,0(a5) # 10000000 <_start-0x70000000>
    {
        printchar(sign);
    }
    
    while(i < MAX_INT_DIGITS)
    80000410:	00900793          	li	a5,9
    80000414:	02c7cc63          	blt	a5,a2,8000044c <printint+0x88>
    80000418:	00c107b3          	add	a5,sp,a2
    8000041c:	00110713          	addi	a4,sp,1
    80000420:	00c70733          	add	a4,a4,a2
    80000424:	00900693          	li	a3,9
    80000428:	40c6863b          	subw	a2,a3,a2
    8000042c:	02061613          	slli	a2,a2,0x20
    80000430:	02065613          	srli	a2,a2,0x20
    80000434:	00c70633          	add	a2,a4,a2
inline void printchar(char chr) { *(TDR) = chr; }  // write into TDR 
    80000438:	100006b7          	lui	a3,0x10000
    {
        printchar(num[i]);
    8000043c:	0007c703          	lbu	a4,0(a5)
inline void printchar(char chr) { *(TDR) = chr; }  // write into TDR 
    80000440:	00e68023          	sb	a4,0(a3) # 10000000 <_start-0x70000000>
    while(i < MAX_INT_DIGITS)
    80000444:	00178793          	addi	a5,a5,1
    80000448:	fec79ae3          	bne	a5,a2,8000043c <printint+0x78>
        i=i+1;
    }
}
    8000044c:	01010113          	addi	sp,sp,16
    80000450:	00008067          	ret

0000000080000454 <pollkbd>:


// check if keyboard buffer has some data
inline int pollkbd() { return *(RCR); } // returns value of RCR  (don't forget to specify "volatile"!) 
    80000454:	100007b7          	lui	a5,0x10000
    80000458:	0057c503          	lbu	a0,5(a5) # 10000005 <_start-0x6ffffffb>
    8000045c:	0ff57513          	andi	a0,a0,255
    80000460:	00008067          	ret

0000000080000464 <readchar>:

// read next character from keyboard buffer
//inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
inline int readchar() { return *(RDR); } // returns value of RDR  (don't forget to specify "volatile"!) 
    80000464:	100007b7          	lui	a5,0x10000
    80000468:	0007c503          	lbu	a0,0(a5) # 10000000 <_start-0x70000000>
    8000046c:	0ff57513          	andi	a0,a0,255
    80000470:	00008067          	ret

0000000080000474 <readslider>:
//{ 
//	return *(STR); 
//}

inline int readslider() {
 int n = 0b11111 - *(SLD); 
    80000474:	0ffff7b7          	lui	a5,0xffff
    80000478:	00479793          	slli	a5,a5,0x4
    8000047c:	0147a703          	lw	a4,20(a5) # ffff014 <_start-0x70000fec>
    80000480:	01f00793          	li	a5,31
    80000484:	40e787bb          	subw	a5,a5,a4
 if(n > 27) n = 27;
 return n;
    80000488:	00078513          	mv	a0,a5
    8000048c:	0007879b          	sext.w	a5,a5
    80000490:	01b00713          	li	a4,27
    80000494:	00f75463          	bge	a4,a5,8000049c <readslider+0x28>
    80000498:	01b00513          	li	a0,27
 }
    8000049c:	0005051b          	sext.w	a0,a0
    800004a0:	00008067          	ret

00000000800004a4 <readstr>:

// read characters into provided buffer until either user presses enter or the buffer size is reached.
int readstr(char *buf, int size)
{
    800004a4:	00050693          	mv	a3,a0
    int count;
    
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
    800004a8:	00100793          	li	a5,1
    800004ac:	04b7d463          	bge	a5,a1,800004f4 <readstr+0x50>
    800004b0:	fff5861b          	addiw	a2,a1,-1
    
    count = 0;
    800004b4:	00000513          	li	a0,0
inline int pollkbd() { return *(RCR); } // returns value of RCR  (don't forget to specify "volatile"!) 
    800004b8:	10000737          	lui	a4,0x10000
       
       // read next character into the current element of the buffer
       *buf = (char)readchar();
       
       // if the user pressed Enter, stop reading
       if (*buf == ENTER_CHAR_CODE) 
    800004bc:	00d00593          	li	a1,13
inline int pollkbd() { return *(RCR); } // returns value of RCR  (don't forget to specify "volatile"!) 
    800004c0:	00574783          	lbu	a5,5(a4) # 10000005 <_start-0x6ffffffb>
       while ((pollkbd() & RDR_READY_BIT) == 0) 
    800004c4:	0017f793          	andi	a5,a5,1
    800004c8:	fe078ce3          	beqz	a5,800004c0 <readstr+0x1c>
inline int readchar() { return *(RDR); } // returns value of RDR  (don't forget to specify "volatile"!) 
    800004cc:	00074783          	lbu	a5,0(a4)
    800004d0:	0ff7f793          	andi	a5,a5,255
       *buf = (char)readchar();
    800004d4:	00f68023          	sb	a5,0(a3)
       if (*buf == ENTER_CHAR_CODE) 
    800004d8:	00b78a63          	beq	a5,a1,800004ec <readstr+0x48>
       {
           break;
       }
       
       // move pointer to the next element of the buffer
       buf += 1;
    800004dc:	00168693          	addi	a3,a3,1
       
       // increase the number of characters in the buffer
       count += 1;
    800004e0:	0015051b          	addiw	a0,a0,1
       
       // decrease the remaining space in the buffer
       size -= 1;
       
    } while(size > 1);  // keep going until one empty char remains (to hold the final '\0' character
    800004e4:	fcc51ee3          	bne	a0,a2,800004c0 <readstr+0x1c>
       count += 1;
    800004e8:	00060513          	mv	a0,a2
    
    *buf = '\0';  // add the end-of-string marker '\0'
    800004ec:	00068023          	sb	zero,0(a3)
    
    return count; // return the number of characters in the read string
    800004f0:	00008067          	ret
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
    800004f4:	fff00513          	li	a0,-1
}
    800004f8:	00008067          	ret

00000000800004fc <readint>:

//read signed integer
int readint()
{
    int res = 0;
    int sign = 1;
    800004fc:	00100813          	li	a6,1
    int res = 0;
    80000500:	00000513          	li	a0,0
inline int pollkbd() { return *(RCR); } // returns value of RCR  (don't forget to specify "volatile"!) 
    80000504:	10000737          	lui	a4,0x10000
           sign = -1;
       }
       else
       {
           // otherwise, if a non-digit is read, it signifies the end of the number
           if (chr < '0' || chr > '9') 
    80000508:	00900593          	li	a1,9
       if (res == 0 && sign == 1 && chr == '-') 
    8000050c:	00100893          	li	a7,1
    80000510:	02d00313          	li	t1,45
           sign = -1;
    80000514:	fff00e13          	li	t3,-1
    80000518:	0200006f          	j	80000538 <readint+0x3c>
           if (chr < '0' || chr > '9') 
    8000051c:	fd06061b          	addiw	a2,a2,-48
    80000520:	04c5e263          	bltu	a1,a2,80000564 <readint+0x68>
           {
               break;
           }
           // incorporate the read digit into the number (N.B. chr - '0' gived the digit value).
           res = res * 10 + (chr - '0');
    80000524:	0025169b          	slliw	a3,a0,0x2
    80000528:	00a686bb          	addw	a3,a3,a0
    8000052c:	0016969b          	slliw	a3,a3,0x1
    80000530:	fd07879b          	addiw	a5,a5,-48
    80000534:	00d7853b          	addw	a0,a5,a3
inline int pollkbd() { return *(RCR); } // returns value of RCR  (don't forget to specify "volatile"!) 
    80000538:	00574783          	lbu	a5,5(a4) # 10000005 <_start-0x6ffffffb>
       while ((pollkbd() & RDR_READY_BIT) == 0) 
    8000053c:	0017f793          	andi	a5,a5,1
    80000540:	fe078ce3          	beqz	a5,80000538 <readint+0x3c>
inline int readchar() { return *(RDR); } // returns value of RDR  (don't forget to specify "volatile"!) 
    80000544:	00074783          	lbu	a5,0(a4)
    80000548:	0ff7f613          	andi	a2,a5,255
    8000054c:	00060793          	mv	a5,a2
       if (res == 0 && sign == 1 && chr == '-') 
    80000550:	fc0516e3          	bnez	a0,8000051c <readint+0x20>
    80000554:	fd1814e3          	bne	a6,a7,8000051c <readint+0x20>
    80000558:	fc6612e3          	bne	a2,t1,8000051c <readint+0x20>
           sign = -1;
    8000055c:	000e0813          	mv	a6,t3
    80000560:	fd9ff06f          	j	80000538 <readint+0x3c>
       }
    }
    
    // return the absolute value of the number (constructed from entered digits) multiplied by the sign.
    return sign * res;
}
    80000564:	02a8053b          	mulw	a0,a6,a0
    80000568:	00008067          	ret

000000008000056c <showpic>:
    # as long as this function is not calling other functions.
    
    .globl showpic
    
showpic:
    li t0,0xffff8000    # starting address of the graphics display
    8000056c:	000202b7          	lui	t0,0x20
    80000570:	fff2829b          	addiw	t0,t0,-1
    80000574:	00f29293          	slli	t0,t0,0xf
    li t1,32            # number of lines on the display (each word encodes one line) 
    80000578:	02000313          	li	t1,32

000000008000057c <loop>:
loop:
    lw t2,0(a0)         # load next line (word) of the picture data
    8000057c:	00052383          	lw	t2,0(a0)
    sw t2,0(t0)         # write it to the corresponding line of the graphics display
    80000580:	0072a023          	sw	t2,0(t0) # 20000 <_start-0x7ffe0000>
    addi t0,t0,4        # move to the next line of the graphics display
    80000584:	00428293          	addi	t0,t0,4
    addi a0,a0,4        # move to the next line of the picture data
    80000588:	00450513          	addi	a0,a0,4
    addi t1,t1,-1       # reduce the number of remaining lines
    8000058c:	fff30313          	addi	t1,t1,-1
    bnez t1,loop        # keep going until all lines on the display are filled with data
    80000590:	fe0316e3          	bnez	t1,8000057c <loop>
    jr ra               # return 
    80000594:	00008067          	ret

0000000080000598 <readstartbutton>:

    .text
    .globl readstartbutton
    
readstartbutton:
    li t0,0xffff0010   
    80000598:	000102b7          	lui	t0,0x10
    8000059c:	fff2829b          	addiw	t0,t0,-1
    800005a0:	01029293          	slli	t0,t0,0x10
    800005a4:	01028293          	addi	t0,t0,16 # 10010 <_start-0x7ffefff0>
    lw a0, 0(t0)  
    800005a8:	0002a503          	lw	a0,0(t0)
              
    jr ra               # return 
    800005ac:	00008067          	ret
