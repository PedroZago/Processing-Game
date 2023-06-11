import java.util.List;
import java.util.stream.Collectors;
import ddf.minim.*;
import processing.sound.*;

SoundFile musicMenu;
SoundFile musicGame;
SoundFile spaceshipEffect;
SoundFile spaceshipDamageEffect;
SoundFile enemyDamageEffect;

// Instancias dos personagens
Spaceship spaceship;
Enemy enemy;

// Instancias das telas
CreditScreen creditScreen;
GameScreen gameScreen;
InitialScreen initialScreen;
StoryScreen storyScreen;
SelectionItensScreen selectionItensScreen;
ControllersScreen controllersScreen;

// Tipos inteiros
int gameTime = 0;
int playerDamageTime = 20;
int enemyDamageTime = 0;
int playerLife = 0;
int backgroundGameX = 0;
int backgroundGameX2 = 1280;
int dificuldade = 0;
int enemyCount = 0;
int scoreEnemies = 0;
int selectedSpaceship = 1;
int spaceShipSelected = 1;

// Tipos PFont
PFont customFont;

// Tipos Float
float buttonWidth = 200;
float buttonHeight = 60;
float defaultButtonSize = 1.0; // Tamanho inicial do botão
float hoverButtonSize = 1.2; // Tamanho do botão quando o cursor estiver sobre ele

// Tipos booleanos
boolean aPressed = false;
boolean dPressed = false;
boolean sPressed = false;
boolean wPressed = false;

// Tipos List e ArrayList
static final List < Bullet > bullets = new ArrayList < > ();
static final List < Integer > bulletPool = new ArrayList < > ();
ArrayList < Enemy > enemys = new ArrayList < Enemy > ();

// Tipos PVector
static final PVector bulletSpd = new PVector();
final PVector targetPlayerPos = new PVector();
PVector playerPos1 = new PVector();
PVector playerPos2 = new PVector();

// Tipos PImage
PImage backgroundGame;
PImage backgroundInitialScreen;
PImage backgroundSelectionScreen;
PImage enemySprite;
PImage asteroidSprite;
PImage playerSprite;
PImage cursor;
PImage keyboardController;
PImage mouseController;
PImage life1;
PImage life2;
PImage life3;
PImage spaceship1;
PImage spaceship2;
PImage spaceship3;
PImage spaceship4;

// Tipos String
String activeScreen = "initialScreen";
String historiaText = "Em um universo distante, a paz do espaço sideral é abalada por uma tempestade de meteoros mortais. Como comandante da nave estelar \"Aurora\", você assume a missão de proteger a Terra e suas colônias espaciais. Através de combates emocionantes, sua coragem será testada enquanto luta para preservar a esperança da humanidade contra a iminente destruição cósmica.";
String creditosText = "Desenvolvido por: \nAna Flavia\nGabriel de Assis\nPedro de Camargo";

// Tipos short
short gunDamage = 10;

void setup() {
  frameRate(60);
  size(800, 600);

  backgroundGame = loadImage("./assets/bg_game.png");
  backgroundGame.resize(1280, 720);
  backgroundInitialScreen = loadImage("./assets/bg_initialScreen.png");
  backgroundInitialScreen.resize(800, 600);
  backgroundSelectionScreen = loadImage("./assets/bg_selectionScreen.png");
  backgroundSelectionScreen.resize(800, 600);

  selectedSpaceship();
  enemySprite = loadImage("./assets/enemy.png");
  asteroidSprite = loadImage("./assets/asteroid.png");
  cursor = loadImage("./assets/scope.png");
  
  spaceship1 = loadImage("./assets/spaceship1.png");
  spaceship2 = loadImage("./assets/spaceship2.png");
  spaceship3 = loadImage("./assets/spaceship3.png");
  spaceship4 = loadImage("./assets/spaceship4.png");
  
  keyboardController = loadImage("./assets/keyboard.png");
  mouseController = loadImage("./assets/mouse.png");
  
  life1 = loadImage("./assets/full_life.png");
  life2 = loadImage("./assets/full_life.png");
  life3 = loadImage("./assets/full_life.png");

  customFont = createFont("./assets/thunderstrikelaser.ttf", 70);
  textAlign(CENTER, CENTER);
  textLeading(30);

  musicMenu = new SoundFile(this, "./assets/musicGame.mp3");
  //musicMenu.loop();
  
  spaceship = new Spaceship(playerSprite, 5);
  enemy = new Enemy(5);

  gameScreen = new GameScreen();
  initialScreen = new InitialScreen();
  creditScreen = new CreditScreen();
  storyScreen = new StoryScreen();
  selectionItensScreen = new SelectionItensScreen();
  controllersScreen = new ControllersScreen();

  cursor(cursor);
}

void draw() {
  cursor(cursor);

  switch (activeScreen) {
  case "creditScreen":
    creditScreen.display();
    break;
  case "gameScreen":
    gameScreen.display();
    break;
  case "initialScreen":
    initialScreen.display();
    break;
  case "storyScreen":
    storyScreen.display();
    break;
  case "selectionItenScreen":
    selectionItensScreen.display();
    break;
  case "controllersScreen":
    controllersScreen.display();
    break;
  default:
    break;
  }
}

void addEnemy(int lf) {
  enemys.add(new Enemy(lf));
  enemyCount++;
}

void addBullets() {
  bulletSpd.set(mouseX, mouseY, 0);
  bulletSpd.sub(targetPlayerPos.x, targetPlayerPos.y);

  if (selectedSpaceship == 1) {
    bulletSpd.setMag(10);
  } else if (selectedSpaceship == 2) {
    bulletSpd.setMag(10);
  } else if (selectedSpaceship == 3) {
    bulletSpd.setMag(10);
  }

  bullets.add(new Bullet(targetPlayerPos, bulletSpd, gunDamage));
}

void selectedSpaceship() {
  if (spaceShipSelected == 1) {
    playerSprite = loadImage("./assets/spaceship1.png");
    gunDamage = 8;
  } else if (spaceShipSelected == 2) {
    playerSprite = loadImage("./assets/spaceship2.png");
    gunDamage = 10;
  } else if (spaceShipSelected == 3) {
    playerSprite = loadImage("./assets/spaceship3.png");
    gunDamage = 12;
  } else if (spaceShipSelected == 3) {
    playerSprite = loadImage("./assets/spaceship4.png");
    gunDamage = 14;
  }
}

void updateBullets() {
  fill(Bullet.COLOUR);

  for (int b = bullets.size() - 1; b >= 0; b--) {
    Bullet bul = bullets.get(b);

    if (bul.script()) {
      bulletPool.add(b);
    }

    for (int e = enemys.size() - 1; e >= 0; e--) {
      Enemy d = enemys.get(e);

      if (bul.pos.x >= d.enemyPos1.x && bul.pos.x <= d.enemyPos2.x &&
        bul.pos.y >= d.enemyPos1.y && bul.pos.y <= d.enemyPos2.y) {

        d.enemyLife -= bul.gunDamage;
        bullets.remove(b);

        if (d.enemyLife <= 0) {
          scoreEnemies++;
          enemys.remove(e);
        }

        break;
      }
    }
  }
}

void newGame() {
  enemys.clear();

  gameTime = 0;
  scoreEnemies = 0;
  playerLife = 3;
  
  life1 = loadImage("./assets/full_life.png");
  life2 = loadImage("./assets/full_life.png");
  life3 = loadImage("./assets/full_life.png");
}

void drawButton(float x, float y, String label) {
  float buttonX = x - buttonWidth / 2;
  float buttonY = y - buttonHeight / 2;

  boolean isHovered = mouseX > buttonX && mouseX < buttonX + buttonWidth && mouseY > buttonY && mouseY < buttonY + buttonHeight;

  float buttonSize = isHovered ? hoverButtonSize : defaultButtonSize;

  stroke(255, 255, 0);
  fill(0);
  rectMode(CENTER);
  rect(x, y, buttonWidth * buttonSize, buttonHeight * buttonSize);

  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(label, x, y);
}

void mousePressed() {
  if (activeScreen.equals("initialScreen")) {
    if (checkButtonPress(width / 2, height / 2 - 100, "selectionItenScreen")) {
      activeScreen = "selectionItenScreen"; // Mudar para a tela de selecionar item
    } else if (checkButtonPress(width / 2, height / 2, "creditScreen")) {
      activeScreen = "creditScreen"; // Mudar para a tela de créditos
    } else if (checkButtonPress(width / 2, height / 2 + 100, "storyScreen")) {
      activeScreen = "storyScreen"; // Mudar para a tela de história
    } else if (checkButtonPress(width / 2, height / 2 + 200, "controllersScreen")) {
      activeScreen = "controllersScreen"; // Mudar para a tela de controles
    }
  } else if (activeScreen.equals("storyScreen") || activeScreen.equals("creditScreen") || activeScreen.equals("selectionItenScreen") || activeScreen.equals("controllersScreen")) {
    if (checkButtonPress(width / 2, height - 50, "initialScreen")) {
      activeScreen = "initialScreen"; // Mudar para a tela de menu
    }
  } else if (activeScreen.equals("gameScreen")) {
    if (playerLife == 0) {
      if (checkButtonPress(width / 2, height / 2, "selectionItenScreen")) {
        newGame();
      } else if (checkButtonPress(width / 2, height / 2 + 100, "creditScreen")) {
        activeScreen = "initialScreen"; // Mudar para a tela de créditos
      }
    } else {
      addBullets();
    }
  }
}

boolean checkButtonPress(float x, float y, String message) {
  if (mouseX > x - buttonWidth / 2 && mouseX < x + buttonWidth / 2 && mouseY > y - buttonHeight / 2 && mouseY < y + buttonHeight / 2) {
    println(message);
    return true;
  }
  return false;
}

void keyPressed() {
  char keyChar = Character.toUpperCase(key);
  if (keyChar == 'W') {
    wPressed = true;
  } else if (keyChar == 'S') {
    sPressed = true;
  } else if (keyChar == 'D') {
    dPressed = true;
  } else if (keyChar == 'A') {
    aPressed = true;
  }
}

void keyReleased() {
  char keyChar = Character.toUpperCase(key);
  if (keyChar == 'W') {
    wPressed = false;
  } else if (keyChar == 'S') {
    sPressed = false;
  } else if (keyChar == 'D') {
    dPressed = false;
  } else if (keyChar == 'A') {
    aPressed = false;
  }
}
