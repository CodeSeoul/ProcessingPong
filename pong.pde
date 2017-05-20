/*
  Variables are ways to track changing information.
  To declare a variable you need the data type, the name, and (optionally)
  a value. It should look like
  dataType name = value;
  In the lines below, we add "final" because we don't want the values 
  to change.
*/
final int MOVE_SPEED = 20;
final int BALL_MOVE_SPEED = 5;

/*
  This is how to create a new object from a class. 
  Defining a class creates a new type of data. 
  In this case, the class is "Paddle", so
  the player1 and player2 variables are
  "Paddle" type of variables.
*/
Paddle player1 = new Paddle();
Paddle player2 = new Paddle();

Ball ball = new Ball();

int player1Score = 0;
int player2Score = 0;

/*
  Here, we're defining a function called setup.
  Processing executes this function once when 
  we run the sketch.
  
  Defining functions takes the bellow form
  outputDataType name(inputs) { }
  
  Inputs are optional. As you can see, there 
  are no inputs below. "void" means there is
  no data output.
  Things between curly brackets {} are the
  "body" of the function. The body of the
  function is the code that executes
  when the function is called.
*/
void setup() {
  // Size defines the size of the window.
  // The first number is the width; the second is the height
  size(1024, 768);
  // This sets the background color. 0 is black.
  background(0);
  
  /*
    player1 and player2 are paddles. Paddles have x and y 
    properties. x is the horizontal position. y is the
    vertical position. In Processing, (0,0) is at the
    top left corner.
  */
  player1.x = 10;
  player1.y = 10;
  
  player2.x = width - 40; 
  /* 
    40 because we want it 10 away from the screen edge, it's 30 wide, 
    and it's x is on the left side
  */
  player2.y = 10;
  
  // This calculates the middle of the screen
  ball.x = (width / 2) - (ball.ballSize / 2);
  ball.y = (height / 2) - (ball.ballSize / 2);
  
  // This sets the size for any text we draw
  textSize(64);
}

// The draw function is executed for every frame
void draw() {
  background(0);
  player1.draw();
  player2.draw();
  ball.draw();
  text(player1Score, 40, 100);
  text(player2Score, width - 80, 100);
}

void keyPressed() {
  // player 1 down
  if(key == 'a' && player1.y + player1.height < height) {
    player1.y += MOVE_SPEED; // += is the same as rectY = rectY + ...
  }
  // player 1 up
  if(key == 'q' && player1.y > 0) {
    player1.y -= MOVE_SPEED;
  }
  // player 2 down
  if(key == 'l' && player2.y + player2.height < height) { // L
    player2.y += MOVE_SPEED;
  }
  // player 2 up
  if(key == 'p' && player2.y > 0) {
    player2.y -= MOVE_SPEED;
  }
}

class Paddle {
  public int x, y;
  
  public final int width = 30;
  public final int height = 100;
  
  void draw() {
    rect(x, y, width, height);
  }
}

class Ball {
  public int x, y;
  
  public final int ballSize = 10;
  
  public int xVelocity = BALL_MOVE_SPEED;
  public int yVelocity = BALL_MOVE_SPEED;
  
  void draw() {
    
    if(y + yVelocity < 0 || y + ballSize + yVelocity > height) {
      yVelocity *= -1;
    }
    
    if((y + ballSize > player1.y &&
      y < player1.y + player1.height &&
      x + xVelocity < player1.x) 
      ||
      (y + ballSize > player2.y &&
      y < player2.y + player2.height &&
      x + ballSize + xVelocity > player2.x)) {
        xVelocity *= -1;
    }
    
    if(x + xVelocity < 0) {
      player2Score += 1;
      ball.x = (width / 2) - (ball.ballSize / 2);
      ball.y = (height / 2) - (ball.ballSize / 2);
    }
    if(x + ballSize + xVelocity > width) {
      player1Score += 1;
      ball.x = (width / 2) - (ball.ballSize / 2);
      ball.y = (height / 2) - (ball.ballSize / 2);
    }
    
    x += xVelocity;
    y += yVelocity;
    rect(x, y, ballSize, ballSize);
  }
}