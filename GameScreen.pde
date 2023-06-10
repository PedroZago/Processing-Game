class GameScreen extends Screen {
  GameScreen() {
    super();
  }

  void display() {
    drawBackground();
    drawLife();
    spawnEnemy();
    checkPlayerEnemyCollision();
    updateGameTime();
    spaceship.display();
    spaceship.drive();
    updateBullets();
  }

  void drawLife() {
    image(life1, 20, 20);
    image(life2, 20, 50);
    image(life3, 20, 80);
  }

  void drawBackground() {
    image(backgroundGame, backgroundGameX, 0);
    image(backgroundGame, backgroundGameX2, 0);

    backgroundGameX = (backgroundGameX - 1) % 1280;
    backgroundGameX2 = (backgroundGameX2 - 1) % 1280;
  }

  void spawnEnemy() {
    if (gameTime % 60 == 0) {
      addEnemy(enemySprite, 10);
    }
  }

  void checkPlayerEnemyCollision() {
    for (Enemy ene: enemys) {
      if (checkCollisionWithPlayer(ene)) {
        handlePlayerEnemyCollision(ene);
      }

      ene.script(targetPlayerPos);
      if (enemyDamageTime == 0) {
        enemyDamageTime = 10;
      } else {
        enemyDamageTime--;
      }
    }
  }

  boolean checkCollisionWithPlayer(Enemy ene) {
    return ene.enemyPos.x + 25 >= playerPos1.x && ene.enemyPos.x - 25 <= playerPos2.x &&
      ene.enemyPos.y + 25 >= playerPos1.y && ene.enemyPos.y - 25 <= playerPos2.y;
  }

  void handlePlayerEnemyCollision(Enemy ene) {
    if (playerDamageTime == 0) {
      if (playerLife > 0) {
        if (playerLife == 3) {
          life3 = loadImage("./assets/empty_life.png");
          playerLife--;
        } else if (playerLife == 2) {
          life2 = loadImage("./assets/empty_life.png");
          playerLife--;
        } else if (playerLife == 1) {
          life1 = loadImage("./assets/empty_life.png");
          playerLife--;
        }
      }
      playerDamageTime = 20;
    } else {
      playerDamageTime--;
    }

    println("**************** alien " + ene.enemyId + " te atacou");
  }

  void updateGameTime() {
    gameTime++;
  }
}
