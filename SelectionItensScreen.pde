class SelectionItensScreen {
  int imageSize = 100;
  
  SelectionItensScreen() {
    super();
  }
  
  void display() {
    background(backgroundInitialScreen);
    textAlign(CENTER, TOP);
    textSize(30);
    fill(255);
    
    text("Selecione seu veículo espacial", width / 2, 20);
    
    int button1X = width / 2 - imageSize - 170;
    int button2X = width / 2 - imageSize - 25;
    int button3X = width / 2 + 25;
    int button4X = width / 2 + 171;
    
    drawItemButton(spaceship1, button1X, 246, 1, 8);
    drawItemButton(spaceship2, button2X, 246, 2, 10);
    drawItemButton(spaceship3, button3X, 246, 3, 12);
    drawItemButton(spaceship4, button4X, 246, 4, 14);
    
    fill(200, 200, 200);
    textSize(20);
    text("Vida inimigos: 15", width / 2, height / 2 + 150);
  }
  
  void drawItemButton(PImage buttonImage, int x, int y, int buttonId, int damage) {
    boolean isTouched = mouseX >= x && mouseX <= x + imageSize && mouseY >= y && mouseY <= y + imageSize;
    
    float buttonSize = isTouched ? hoverButtonSize : defaultButtonSize;
    
    fill(255, 140, 0);
    rectMode(CENTER);
    rect(x + imageSize / 2, y + imageSize / 2, 130 * buttonSize, 100 * buttonSize);
    
    imageMode(CENTER);
    image(buttonImage, x + imageSize / 2, y + imageSize / 2, imageSize * buttonSize, imageSize * buttonSize);
    
    fill(200, 200, 200);
    textSize(20);
    text("Dano: " + damage, x + imageSize / 2, y + imageSize + 100 / 2);
    
    if (isTouched && mousePressed) {
      newGame();
      
      if (buttonId == 1) {
        playerSprite = loadImage("./assets/spaceship1.png");
        gunDamage = 8;
      } else if (buttonId == 2) {
        playerSprite = loadImage("./assets/spaceship2.png");
        gunDamage = 10;
      } else if (buttonId == 3) {
        playerSprite = loadImage("./assets/spaceship3.png");
        gunDamage = 12;
      } else if (buttonId == 4) {
        playerSprite = loadImage("./assets/spaceship4.png");
        gunDamage = 14;
      }
      
      activeScreen = "gameScreen";
    }
  }
}
