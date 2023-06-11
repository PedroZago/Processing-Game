class InitialScreen {
  InitialScreen() {
    super();
  }
  
  void display() {
    image(backgroundInitialScreen, 0, 0);
    
    textFont(customFont);
    textSize(70);
    fill(255);
    text("Space Guardian", width / 2, height / 8);
    
    drawButton(width / 2, height / 2 - 100, "Play");
    
    drawButton(width / 2, height / 2, "Créditos");
    
    drawButton(width / 2, height / 2 + 100, "História");
    
    drawButton(width / 2, height / 2 + 200, "Controles");
  }
  
}