class Bullet {
  static final short VEL = 7, DIM = 4, FREQ = 2;
  static final color COLOUR = #0000FF; 

  final PVector pos = new PVector(),
    spd = new PVector();
  boolean isInactive;
  boolean hitEnemy = false;
  boolean firstShot = true;
  short gunDamage;

  Bullet(PVector loc, PVector vel, short dmg) {
    gunDamage = dmg;
    rez(loc, vel);
  }

  void rez(PVector loc, PVector vel) {
    pos.set(loc);
    spd.set(vel);
    isInactive = false;
  }

  void display() {
    stroke(0);
    ellipse(pos.x, pos.y, DIM, DIM);
  }

  void update() {
    pos.add(spd);
  }

  boolean check() {
    return pos.x > width + 50 | pos.x < 50 | pos.y > 50 | pos.y < height - 50;
  }

  boolean script() {
    if (isInactive) return false;
    display();
    update();
    return isInactive = check() && hitEnemy;
  }
}
