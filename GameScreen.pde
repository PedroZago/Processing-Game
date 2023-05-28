class GameScreen extends Screen {
  GameScreen() {
    super();
  }
  
  void display() {
    drawBackground();
    spawnEnemy();
    checkPlayerEnemyCollision();
    updateGameTime();
    spaceship.display();
    spaceship.drive();
    updateBullets();
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
    for (Enemy ene : enemys) {
      if (checkCollisionWithPlayer(ene)) {
        handlePlayerEnemyCollision(ene);
      }
      
      ene.script(targetPlayerPos);
      enemyDamageTime = max(0, enemyDamageTime - 1);
    }
  }
  
  boolean checkCollisionWithPlayer(Enemy ene) {
    return ene.enemyPos.x + 25 >= playerPos1.x && ene.enemyPos.x - 25 <= playerPos2.x && 
    ene.enemyPos.y + 25 >= playerPos1.y && ene.enemyPos.y - 25 <= playerPos2.y;
  }
  
  void handlePlayerEnemyCollision(Enemy ene) {
    if (playerDamageTime == 0 && playerLife > 0 && playerLife <= 6) {
      playerLife--;
      playerDamageTime = 20;
    } else {
      playerDamageTime = max(0, playerDamageTime - 1);
    }
    println("**************** alien " + ene.enemyId + " te atacou");
  }
  
  void updateGameTime() {
    gameTime++;
  }
}
