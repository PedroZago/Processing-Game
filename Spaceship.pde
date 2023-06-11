class Spaceship {
  PVector spaceshipPos = new PVector(0, 0);
  
  float angleAim = 0;
  
  int motionPixels;
  int initialPosX = width / 2;
  int initialPosY = height / 2;
    
  Spaceship(int tempMotionPixels) {
    motionPixels = tempMotionPixels;
  }
  
  void display() {
    pushMatrix();
    angleAim = atan2(spaceshipPos.x - mouseX, spaceshipPos.y - mouseY);
    translate(spaceshipPos.x, spaceshipPos.y);
    rotate( -angleAim - HALF_PI);
    image(playerSprite, 0, 0);
    popMatrix();
  }
  
  void drive() {
    handleMotionInput();
    updateSpaceshipPosition();
    updatePlayerPositions();
  }
  
  void handleMotionInput() {
    if (aPressed && initialPosX > 0) {
      initialPosX -= motionPixels;    
    }
    
    if (dPressed && initialPosX < width) {
      initialPosX += motionPixels;
    }
    
    if (wPressed && initialPosY > 0) {
      initialPosY -= motionPixels;     
    }
    
    if (sPressed && initialPosY < height) {
      initialPosY += motionPixels;     
    }
  }
  
  void updateSpaceshipPosition() {
    spaceshipPos.set(initialPosX, initialPosY, 0);
  }
  
  void updatePlayerPositions() {
    playerPos1.set(spaceshipPos.x - 20, spaceshipPos.y - 20);
    playerPos2.set(spaceshipPos.x + 20, spaceshipPos.y + 20);
    
    targetPlayerPos.set(spaceshipPos.x, spaceshipPos.y);
  }
}
