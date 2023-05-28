import processing.sound.*; // Boblioteca musica

SoundFile music;

PImage backgroundImage;
PFont customFont; // Declaração global da variável customizarFonte

String gameState = "menu";

float buttonWidth = 200;
float buttonHeight = 50;
float defaultButtonSize = 1.0; // Tamanho inicial do botão
float hoverButtonSize = 1.2; // Tamanho do botão quando o cursor estiver sobre ele

String historiaText = "Em um universo distante, a paz do espaço sideral é abalada por uma tempestade de meteoros mortais. Como comandante da nave estelar \"Aurora\", você assume a missão de proteger a Terra e suas colônias espaciais. Através de combates emocionantes, sua coragem será testada enquanto luta para preservar a esperança da humanidade contra a iminente destruição cósmica.";
String tituHistoriaText = "História";
String creditosText = "Desenvolvido por: \nAna Flavia\nGabriel de Assis\nPedro de Camargo";

void setup() {
  size(800, 600);
  backgroundImage = loadImage("espaço1.png");
  customFont = createFont("thunderstrikelaser.ttf", 70); // Carrega a fonte personalizada
  textAlign(CENTER, CENTER);
  textLeading(30);
  
  //adciona a musica
  music = new SoundFile(this, "musicGame.mp3");
  music.loop();
}

void draw() {

  image(backgroundImage, 0, 0, width, height);

  if (gameState.equals("menu")) {
    drawMenuScreen();
  } else if (gameState.equals("historia")) {
    drawHistoriaScreen();
  } else if (gameState.equals("creditos")) {
    drawCreditosScreen();
  }
}

void drawMenuScreen() {
  // Título do jogo
  textFont(customFont);
  textSize(70);
  fill(255);
  text("Space guardian", width/2, height/4);

  // Botão "Play"
  drawButton(width/2, height/2 - 50, "Play");

  // Botão "Créditos"
  drawButton(width/2, height/2 + 50, "Créditos");

  // Botão "História"
  drawButton(width/2, height/2 + 150, "História");
}

void drawHistoriaScreen() {
  // Caixa de texto da história
  float boxWidth = 700;
  float boxHeight = 500;
  float boxX = width/2 - boxWidth/2;
  float boxY = height/2 - boxHeight/2;

  // Desenhar caixa de texto
  fill(0, 150);
  stroke(255);
  rect(boxX + 350, boxY + 230, boxWidth -230, boxHeight -40);

  // Título da História
  fill(200, 200, 0);
  textSize(50);
  text(tituHistoriaText, boxX + 350, boxY + 40, boxWidth - 250, boxHeight - 40);

  // Texto da história
  fill(200, 200, 200);
  textSize(20);
  text(historiaText, boxX + 350, boxY + 270, boxWidth - 250, boxHeight - 40);

  // Botão de voltar
  drawButton(width/2, height - 50, "Voltar");
}

void drawCreditosScreen() {
  // Caixa de texto dos créditos
  float boxWidth = 700;
  float boxHeight = 500;
  float boxX = width/2 - boxWidth/2;
  float boxY = height/2 - boxHeight/2;

  // Desenhar caixa de texto
  fill(0, 150);
  stroke(255);
  rect(boxX + 350, boxY + 230, boxWidth - 230, boxHeight - 40);

  // Título dos créditos
  fill(200, 200, 0);
  textSize(50);
  text("Créditos", boxX + 350, boxY + 40, boxWidth - 250, boxHeight - 40);

  // Texto dos créditos
  fill(200, 200, 200);
  textSize(30);
  text(creditosText, boxX + 350, boxY + 200, boxWidth - 250, boxHeight - 40);

  // Botão de voltar
  drawButton(width/2, height - 50, "Voltar");
}

void drawButton(float x, float y, String label) {
  float buttonX = x - buttonWidth/2;
  float buttonY = y - buttonHeight/2;

  // Verificar se o cursor está sobre o botão
  boolean isHovered = mouseX > buttonX && mouseX < buttonX + buttonWidth && mouseY > buttonY && mouseY < buttonY + buttonHeight;

  // Ajustar o tamanho do botão com base no cursor
  float buttonSize = isHovered ? hoverButtonSize : defaultButtonSize;

  // Desenhar botão
  stroke(255, 255, 0);
  fill(0);
  rectMode(CENTER);
  rect(x, y, buttonWidth * buttonSize, buttonHeight * buttonSize);

  // Desenhar texto do botão
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(label, x, y);
}

void mousePressed() {
  if (gameState.equals("menu")) {
    if (mouseX > width/2 - buttonWidth/2 && mouseX < width/2 + buttonWidth/2) {
      if (mouseY > height/2 - 50 - buttonHeight/2 && mouseY < height/2 - 50 + buttonHeight/2) {
        // Botão "Play" pressionado
        println("Botão Play pressionado");
      } else if (mouseY > height/2 + 50 - buttonHeight/2 && mouseY < height/2 + 50 + buttonHeight/2) {
        // Botão "Créditos" pressionado
        gameState = "creditos"; // Mudar para a tela de créditos
      } else if (mouseY > height/2 + 150 - buttonHeight/2 && mouseY < height/2 + 150 + buttonHeight/2) {
        // Botão "História" pressionado
        gameState = "historia"; // Mudar para a tela de história
      }
    }
  } else if (gameState.equals("historia") || gameState.equals("creditos")) {
    if (mouseX > width/2 - buttonWidth/2 && mouseX < width/2 + buttonWidth/2 && mouseY > height - 50 - buttonHeight/2 && mouseY < height - 50 + buttonHeight/2) {
      // Botão "Voltar" pressionado
      gameState = "menu"; // Voltar para o menu principal
    }
  }
}
