class Bullet {
  static final int DIM = 7;
  static final color COLOUR = #ff0000;
  
  final PVector pos = new PVector();
  final PVector spd = new PVector();
  
  boolean isInactive;
  boolean hitEnemy;
  
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
    return pos.x > width + 50 || pos.x < 50 || pos.y > 50 || pos.y < height - 50;
  }
  
  boolean script() {
    if (isInactive) return false;
    display();
    update();
    isInactive = check() && hitEnemy;
    return isInactive;
  }
}