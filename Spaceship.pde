class Spaceship {
  PVector spaceshipPos = new PVector(0, 0);
  float angleAim = 0;
  int motionPixels;
  int initialPosX = width / 2;
  int initialPosY = height / 2;

  PImage spaceshipImage;

  Spaceship(PImage tempImage, int tempMotionPixels) {
    spaceshipImage = tempImage;
    motionPixels = tempMotionPixels;
  }

  void display() {
    pushMatrix();
    angleAim = atan2(spaceshipPos.x - mouseX, spaceshipPos.y - mouseY);
    translate(spaceshipPos.x, spaceshipPos.y);
    rotate(-angleAim - HALF_PI);
    imageMode(CENTER);
    image(spaceshipImage, 0, 0);
    popMatrix();
  }

  void drive() {
    if (aPressed) {
      if (initialPosX > 0) {
        initialPosX = initialPosX - motionPixels;
      }
    }
    if (dPressed) {
      if (initialPosX < width) {
        initialPosX = initialPosX + motionPixels;
      }
    }
    if (wPressed) {
      if (initialPosY > 0) {
        initialPosY = initialPosY - motionPixels;
      }
    }
    if (sPressed) {
      if (initialPosY < height) {
        initialPosY = initialPosY + motionPixels;
      }
    }

    spaceshipPos.set(initialPosX, initialPosY, 0);
    playerPos1.set(spaceshipPos.x - 20, spaceshipPos.y - 20);
    playerPos2.set(spaceshipPos.x + 20, spaceshipPos.y + 20);
    
    targetPlayerPos.set(spaceshipPos.x, spaceshipPos.y);
  }
}
