Spaceship spaceship;
Enemy enemy;

int enemyDamageTime = 0;
int playerDamageTime = 20;
int gameTime = 0;

boolean wPressed, dPressed, sPressed, aPressed = false;

ArrayList < Enemy > enemys = new ArrayList < Enemy > ();

int playerLife = 6;

final PVector targetPlayerPos = new PVector();

PImage playerSprite;
PImage enemySprite;
PImage backgroundGame;

int dificuldade = 0;
int enemyCount = 0;

PVector playerPos1 = new PVector();
PVector playerPos2 = new PVector();

void setup() {
  frameRate(60);
  size(1280, 720);

  backgroundGame = loadImage("./images/bg_game.png");
  playerSprite = loadImage("./images/spaceship.png");
  enemySprite = loadImage("./images/enemy.png");

  spaceship = new Spaceship(playerSprite, 5);
  enemy = new Enemy(enemySprite, 50);
}

void draw() {
  background(backgroundGame);

  if (gameTime % 60 == 0) {
    addEnemy(enemySprite, 10);
  }

  for (Enemy ene: enemys) {
    if ((ene.enemyPos.x + 25 >= playerPos1.x && ene.enemyPos.x - 25 <= playerPos2.x) &&
      (ene.enemyPos.y + 25 >= playerPos1.y && ene.enemyPos.y - 25 <= playerPos2.y)) {
      if (playerDamageTime == 0) {
        if (playerLife > 0) {
          if (playerLife == 6) {
            playerLife--;
          } else if (playerLife == 5) {
            playerLife--;
          } else if (playerLife == 4) {
            playerLife--;
          } else if (playerLife == 3) {
            playerLife--;
          } else if (playerLife == 2) {
            playerLife--;
          } else if (playerLife == 1) {
            playerLife--;
          }
        }
        playerDamageTime = 20;
      } else {
        playerDamageTime--;
      }

      println("**************** alien " + ene.enemyId + " te atacou");
    }
    ene.script(targetPlayerPos);
    if (enemyDamageTime == 0) {
      enemyDamageTime = 10;
    } else {
      enemyDamageTime--;
    }
  }

  spaceship.display();
  spaceship.drive();
  gameTime++;
}

void addEnemy(PImage img, int lf) {
  enemys.add(new Enemy(img, lf));
  enemyCount++;
}

void keyPressed() {
  if (keyCode == 'W' || keyCode == 'w') {
    wPressed = true;
  } else if (keyCode == 'S' || keyCode == 's') {
    sPressed = true;
  } else if (keyCode == 'D' || keyCode == 'd') {
    dPressed = true;
  } else if (keyCode == 'A' || keyCode == 'a') {
    aPressed = true;
  }
}

void keyReleased() {
  if (keyCode == 'W' || keyCode == 'w') {
    wPressed = false;
  } else if (keyCode == 'S' || keyCode == 's') {
    sPressed = false;
  } else if (keyCode == 'D' || keyCode == 'd') {
    dPressed = false;
  } else if (keyCode == 'A' || keyCode == 'a') {
    aPressed = false;
  }
}
