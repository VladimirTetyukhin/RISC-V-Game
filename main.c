/*
 * Example software running in Logisim RISC-V Computer System model by Pavel Gladyshev
 * licensed under Creative Commons Attribution International license 4.0
 *
 * This example shows how graphics display can be used to dsisplay pictures.
 * 
 * the showpic() function that fills graphics display with the given picture is 
 * written in assembly language (it is in the file showpic.s). 
 * It is declared at the end of lib.h
 * 
 * The picture data for two pictures is defined in pictures.c file,
 * the pictures[] array is declared in pictures.h header file.
 */
 
 #include "lib.h" 

int main() 
{ 
    
    int ballX = 29;
    int ballY = 30;
    int dx = -1;
    int dy = -1;
    int score = 0;
    int slider = 0;
    
    int board[32]; // Array to represent the game board
    // Initializing board
    for (int i = 0; i < 32; ++i){
        board[i] = 0;
    }
    board[16] = -1; // Setting a brick in the middle of the board

    printstr("*** BREAKOUT! ***\n\n");
    
    // Platform-specific setup
    #ifdef QEMU20180
    	slider = 0;
    	printstr("Press any key on the MMIO Keyboard to start\n");
    	
    	while ((pollkbd() & RDR_READY_BIT) == 0) {} // Wait for key press
    	
    	slider = 27;
    	printstr("Control keys: a - move paddle left; d - move paddle right\n");
    
    #else
    
    	printstr("Press START button\n");
    	while(!(readstartbutton())); // Wait for START button press
    	printstr("Use the slider to move the paddle left or right\n");
    #endif
    
    // Main game loop
    while(score >= 0 && score < 32){
        #ifdef QEMU20180
        	int k = readchar();
        	if(k == 'a' && slider < 27) ++slider; // Move paddle left
        	if(k == 'd' && slider > 0) --slider; // Move paddle right
        	for(int i = 0; i < 30000000; ++i){} // Delay for simulation purposes
        #else
        	slider = readslider(); // Read slider position
        #endif
        printscore(score); // Print current score
        
        // Update board with ball and slider positions
        board[ballY] |= (1 << ballX);
        board[31] |= (0b11111 << slider);
        
        showpic(board); // Display current game state
        
        // Clear previous ball and slider positions
        board[ballY] &= ~(1 << ballX); 
        board[31] &= ~(0b11111 << slider);
        
        // Ball movement and collision detection logic
        
        if(ballX == 0 || ballX == 32){ // Left and right borders
            dx = -dx; 
        }
        else if(ballY + dy == 16 && board[16] && (1 << ballX)){ //Hitting the brick wall from up or down
            board[16] &= ~(1 << ballX);
            ++score;
            dy = -dy; 
        }
        else if(ballY == 16 && board[16] && (1 << (ballX + dx))){ //Hitting the brick wall from left or right
            board[16] &= ~(1 << (ballX + dx));
            ++score;
            dx = -dx; 
        }
        else if(ballY + dy == 0){ //Hitting the upper border
            dy = -dy; 
        }
        else if(ballY + dy == 31){
            
            // Collision detection with slider
            if (ballX <= slider + 4 && ballX >= slider){
                dy = -dy; 
            }
        }
        else if(ballY == 32){
            score = -1; // Ball reached bottom, game over
        }
        
        // Update ball position
        ballX += dx;
        ballY += dy;
    }
    
    // Game end conditions
    if(score == 32) {
        printstr("YOU WON!\n");
    }
    printstr("Game over\n");
    
    return 0; // Return 0 to indicate successful execution
}



