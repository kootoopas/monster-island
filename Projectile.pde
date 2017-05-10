class Projectile extends CBeing {

  public static final int SPD = 8;
  public static final int SIZE = 24;

  private Game game;

  private ProjectileTower tower;
  private Creep creep;
  private PImage sprite = assetManager.getImage("arrowProjectile");
  private float orientation = 0;

  public Projectile(ProjectileTower tower, Creep creep, Game game) {
    super(new HRectangle(tower.getCenter().x, tower.getCenter().y + Tower.Y_OFFSET * 0.5, SIZE, SIZE));
    this.game = game;
    this.tower = tower;
    this.creep = creep;

    this.game.register(this);
  }

  public void update() {
    PVector pos = getPosition();
    PVector creepPos = creep.getCenter();

    float dx = creepPos.x - pos.x;
    float dy = creepPos.y - pos.y;
    float dist = sqrt(dx * dx + dy * dy);

    if (dist > SPD) {
      float ratio = SPD / dist;
      float xMove = ratio * dx;
      float yMove = ratio * dy;

      setX(getX() + xMove);
      setY(getY() + yMove);
      _orient(dx, dy);
    } else {
      game.delete(this);
      tower.hit(creep);
    }
  }

  private void _orient(float dx, float dy) {
    orientation = atan2(dy, dx);
  }

  public void draw() {
    rotate(orientation - PI - PI / 4);
    image(sprite, 0, 0);
  }
}