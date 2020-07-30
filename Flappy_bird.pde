/* FLAPPY BIRD IN PROCESSING
 * Language:  Processing (Version of Java)
 * Download: https://processing.org/download/
 */

PImage bg, kirby, topPipe, botPipe;  //Background, Player
int bgx, bgy, kx, ky, g, Vky;
int[] pipeX, pipeY; //DECLARE two arrays 
int gameState, score, highScore;

//ONE TIME
void setup()
{
  size(800,620);
  bg = loadImage("C:\\Users\\ss\\Documents\\Processing\\Flappy_bird\\bg.png");
  kirby = loadImage("C:\\Users\\ss\\Documents\\Processing\\Flappy_bird\\kirby.png");
  botPipe = loadImage("C:\\Users\\ss\\Documents\\Processing\\Flappy_bird\\botPipe.png");
  topPipe = loadImage("C:\\Users\\ss\\Documents\\Processing\\Flappy_bird\\topPipe.png");
  kx = 100;
  ky = 50;
  g = 1; //Gravity == Speed of downward acceleration
  pipeX = new int[5];  //[0,0,0,0]
  pipeY = new int[pipeX.length];
  //POPULATE THE ARRAY WITH VALUES
  for(int i = 0; i < pipeX.length; i++)
  {
    pipeX[i] = width + 200*i;
    pipeY[i] = (int)random(-350, 0);
  } 
  gameState = -1;
}

//MAIN GAME LOOP
void draw()
{
  if(gameState == -1)
  {
    startScreen();  
  }
  else if(gameState==0)
  {
    setBg();
    setPipes();
    kirby(); //PUTS KIRBY ON TOP -- Draws him last
    displayScore();
  }
  else
  {
    endScreen();
    restart();
  }
}

void endScreen()
{
    fill(150, 150, 250, 100);
    if(mouseX > 90 && mouseX < 595 && mouseY > 150 && mouseY < 290)
    {
      fill(150, 250, 150, 100);
    }
    rect(90, 150, 505, 140, 5);
    fill(0);
    textSize(40);
    text("Kirby died     : (", 200,200);
    text("Click HERE to play again." , 100, 270);  
}

void restart()
{
   //CHECK TO MAKE SURE THE MOUSE IS IN THE 'BOX'
   if(mouseX > 90 && mouseX < 595 && mouseY > 150 && mouseY < 290)
   {
     //RESET AND RESTART 
     if(mousePressed)
     {
        ky = height/2;
        for(int i = 0; i < pipeX.length; i++)
        {
          pipeX[i] = width + 200*i;
          pipeY[i] = (int)random(-350, 0);
        }      
        score = 0;
        gameState = 0;  
     } 
   }
}
void displayScore()
{
  if(score>highScore)
  {
    highScore = score;
  }
  //Background for ScoreBoard
  fill(160,160,160, 200); //Last# is opacity (Clearness)
  rect(width-175, 10, 155, 80, 5);
  fill(0);
  textSize(32);
  text("Score: " + score, width - 170, 40);  
  text("High:  " + highScore, width - 170, 80);   
}

void startScreen()
{
  image(bg, 0,0);
  textSize(45);
  text("Welcome to Flappy Bird!", 40, 100);
  text("Click the mouse to begin...", 40, 200);
  if(mousePressed)
  {
    ky = height/2;
    gameState = 0;
  }
}
void setPipes()
{
  //Move the Pipes
  for(int i = 0; i < pipeX.length; i++)
  {
   image(topPipe, pipeX[i], pipeY[i]);
   image(botPipe, pipeX[i], pipeY[i] + 680);
   pipeX[i]-= 2;
   if(score > 10)
   {
     pipeX[i]--;  //Speed up when they reach 10 points
   }
   if(score > 20)
   {
     pipeX[i]--;  //Speed up again at 20 points  
   }
   if(pipeX[i] < -200)
   {
     pipeX[i] = width;  
   }
   
   //Check for Collision
   if(kx > (pipeX[i]-35) && kx < pipeX[i] + 92)
   {
     //End Game is not in SAFE ZONE
     if(!(ky > pipeY[i] + 449 && ky < pipeY[i] + (449 + 231-49)))
     {
       fill(255, 0, 0, 200);
       textSize(24);
       rect(20, height - 223, 455, 32);
       fill(0);
       text("OH NO!!!! KIRBY RAN INTO A PIPE...", 20, height - 200);      
       gameState = 1;
     }
     //Score if pass through pipe
     else if (kx==pipeX[i] || kx == pipeX[i] + 1)
     {
       score++;  
     }
   }
  }  
}


void kirby()
{
   image(kirby, kx, ky);
   ky = ky + Vky;
   Vky = Vky + g;  
   if(ky > height || ky < 0)
   {
     fill(255, 0, 0, 140);
     textSize(24);
     text("OH NO!!!! KIRBY FELL OFF THE SCREEN...", 20, 44);
     gameState=1;
   }
}

void mousePressed()
{
   Vky = -15;  
}

void setBg()
{
  image(bg, bgx, bgy);
  image(bg, bgx + bg.width, bgy);
  bgx--;
  if(bgx < -bg.width)
  {
     bgx = 0; //RESET images to starting position 
  }  
}
