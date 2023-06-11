class CreditScreen {
  CreditScreen() {
    super();
  }
  
  void display() {
    float boxWidth = 700;
    float boxHeight = 500;
    float boxX = width / 2 - boxWidth / 2;
    float boxY = height / 2 - boxHeight / 2;
    
    fill(0, 150);
    stroke(255);
    rect(boxX + 350, boxY + 230, boxWidth - 230, boxHeight - 40);
    
    fill(200, 200, 0);
    textSize(50);
    text("Créditos", boxX + 350, boxY + 40, boxWidth - 250, boxHeight - 40);
    
    fill(200, 200, 200);
    textSize(30);
    text(creditosText, boxX + 350, boxY + 200, boxWidth - 250, boxHeight - 40);
    
    drawButton(width / 2, height - 50, "Voltar");
  }
}