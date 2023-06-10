class Enemy {
  static final float MAX_SPD = 2.0;
  static final float MAX_FORCE = 0.5;
  
  PVector[] posArray = {
    new PVector(width, random(height)),
      new PVector(0, random(height)),
      new PVector(random(width), height),
      new PVector(random(width), 0)
    };
  
  final PVector vel = new PVector(random( - 2, 2), random( - 2, 2));
  final PVector acc = new PVector();
  
  PVector enemyPos1 = new PVector();
  PVector enemyPos2 = new PVector();
  
  PVector randomPos = posArray[parseInt(random(0, 4))];
  PVector enemyPos = new PVector(randomPos.x, randomPos.y);
  
  PImage randomSprite = random(2) < 1 ? enemySprite : asteroidSprite;
    
  int enemyLife;
  int enemyId = enemyCount;
  
  Enemy(int tempLife) {
    enemyLife = tempLife;
  }
  
  void script(PVector target) {
    seek(target);
    update();
    display();
  }
  
  void seek(PVector target) {
    acc.set(target);
    acc.sub(enemyPos);
    acc.setMag(MAX_SPD);
    acc.sub(vel);
    acc.limit(MAX_FORCE);
  }
  
  void update() {
    vel.add(acc);
    vel.limit(MAX_SPD);
    enemyPos.add(vel);
  }
  
  void display() {
    enemyPos1.set(enemyPos);
    enemyPos2.set(enemyPos);
    enemyPos1.sub(20, 20);
    enemyPos2.add(20, 20);
    
    pushMatrix();
    translate(enemyPos.x, enemyPos.y);
    rotate(vel.heading() + HALF_PI);
    image(randomSprite, -15, -15);
    popMatrix();
    
    stroke(255, 0, 255);
    
  }
}
