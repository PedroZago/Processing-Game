import java.util.List;
import java.util.stream.Collectors;
import ddf.minim.*;

// Instancias dos personagens
Spaceship spaceship;
Enemy enemy;

// Instancias das telas
AboutScreen aboutScreen;
GameScreen gameScreen;
InitialScreen initialScreen;
InstructionsScreen instructionsScreen;
SelectionItensScreen selectionItensScreen;

// Tipos inteiros
int gameTime = 0;
int playerDamageTime = 20;
int enemyDamageTime = 0;
int playerLife = 6;
int backgroundGameX = 0;
int backgroundGameX2 = 1280;
int dificuldade = 0;
int enemyCount = 0;
int scoreEnemies = 0;
int selectedSpaceship = 1;

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
PImage enemySprite;
PImage playerSprite;

// Tipos String
String activeScreen = "gameScreen";

// Tipos short
short gunDamage = 10;

void setup() {
  frameRate(60);
  size(1280, 720);
  
  backgroundGame = loadImage("./images/bg_game.png");
  backgroundGame.resize(1285, 720);
  
  playerSprite = loadImage("./images/spaceship.png");
  enemySprite = loadImage("./images/enemy.png");
  
  spaceship = new Spaceship(playerSprite, 5);
  enemy = new Enemy(enemySprite, 5);
  gameScreen = new GameScreen();
}

void draw() {
  switch(activeScreen) {
    case "aboutScreen":
      break;
    case "gameScreen":
      gameScreen.display();
      break;
    case "initialScreen":
      break;
    case "instructionsScreen":
      break;
    case "selectionItenScreen":
      break;
    default:
    break;
  }
  
  println("score enemies: " + scoreEnemies);
}

void addEnemy(PImage img, int lf) {
  enemys.add(new Enemy(img, lf));
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
  playerLife = 6;
}

void mousePressed() {
  addBullets();
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
  } else if (keyChar == 'R') {
    newGame();
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
