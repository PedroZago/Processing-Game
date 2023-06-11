class GameScreen {
  GameScreen() {
    super();
  }
  
  void display() {
    imageMode(CORNER);
    
    image(backgroundGame, 0, 0);
    if (playerLife == 0) {
      textFont(customFont);
      fill(200, 200, 200);
      textSize(20);
      
      drawScore();
      
      drawButton(width / 2, height / 2, "Jogar\nnovamente");
      drawButton(width / 2, height / 2 + 100, "Voltar");
      
    } else {
      drawBackground();
      drawLife();
      drawScore();
      spawnEnemy();
      checkPlayerEnemyCollision();
      updateGameTime();
      spaceship.display();
      spaceship.drive();
      updateBullets();
    }
  }
  
  void drawLife() {
    image(life1, 20, 20);
    image(life2, 20, 50);
    image(life3, 20, 80);
  }
  
  void drawScore() {
    textFont(customFont);
    fill(200, 200, 200);
    textSize(20);
    text("Pontuação: " + scoreEnemies, 690, 30);
  }
  
  void drawBackground() {
    image(backgroundGame, backgroundGameX, 0);
    image(backgroundGame, backgroundGameX2, 0);
    
    backgroundGameX = (backgroundGameX - 1) % 1280;
    backgroundGameX2 = (backgroundGameX2 - 1) % 1280;
  }
  
  void spawnEnemy() {
    int spawnFrequency = 60 + enemyCount / 10;
    
    if (gameTime % spawnFrequency == 0) {
      if (enemyCount % 30 == 0) {
        addEnemy(30);
        addEnemy(20);
        addEnemy(20);
      } else if (enemyCount % 10 == 0) {
        addEnemy(20);
        addEnemy(20);
      } else {
        addEnemy(10);
      }
    }
  }
  
  void checkPlayerEnemyCollision() {
    for (Enemy ene : enemys) {
      if (checkCollisionWithPlayer(ene)) {
        handlePlayerEnemyCollision(ene);
      }
      
      ene.script(targetPlayerPos);
      enemyDamageTime = (enemyDamageTime == 0) ? 10 : enemyDamageTime - 1;
    }
  }
  
  boolean checkCollisionWithPlayer(Enemy ene) {
    return ene.enemyPos.x + 25 >= playerPos1.x && ene.enemyPos.x - 25 <= playerPos2.x && 
    ene.enemyPos.y + 25 >= playerPos1.y && ene.enemyPos.y - 25 <= playerPos2.y;
  }
  
  void handlePlayerEnemyCollision(Enemy ene) {
    if (playerDamageTime == 0 && playerLife > 0) {
      switch(playerLife) {
        case 3:
          life3 = loadImage("./assets/empty_life.png");
          break;
        case 2:
          life2 = loadImage("./assets/empty_life.png");
          break;
        case 1:
          life1 = loadImage("./assets/empty_life.png");
          break;
      }
      playerLife--;
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