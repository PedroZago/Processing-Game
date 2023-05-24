class Enemy {
  static final float MAX_SPD = 2.0;
  static final float MAX_FORCE = .5;
  static final float WEIGHT = 1.5;
  
  PVector initialPos = new PVector(width, parseInt(random(0, height)));

  final PVector vel = new PVector(random(-2, 2), random(-2, 2));
  final PVector acc = new PVector();
  PVector enemyPos1 = new PVector();
  PVector enemyPos2 = new PVector();
  PImage enemyImage;

  int enemyLife;
  int enemyId = enemyCount;
  PVector enemyPos = new PVector(initialPos.x, initialPos.y);

  Enemy(PImage tempImage, int tempLife) {
    enemyImage = tempImage;
    enemyLife = tempLife;
  }

  void script(PVector target) {
    seek(target);
    update();
    display();
  }

  void seek(PVector target) {
    PVector.sub(target, enemyPos, acc).setMag(MAX_SPD);
    PVector.sub(acc, vel, acc).limit(MAX_FORCE);
  }

  void update() {
    vel.add(acc);
    vel.limit(MAX_SPD);
    enemyPos.add(vel);
  }

  void display() {
    enemyPos1.x = enemyPos.x - 20;
    enemyPos2.x = enemyPos.x + 20;
    enemyPos1.y = enemyPos.y - 20;
    enemyPos2.y = enemyPos.y + 20;

    translate(enemyPos.x, enemyPos.y);
    rotate(vel.heading() + HALF_PI);
    image(enemyImage, -15, -15);

    stroke(255, 0, 255);
    resetMatrix();
  }
}
