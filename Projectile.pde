class Projectile extends CBeing {

  public static final int SPD = 8;
  public static final int SIZE = 24;

  private Game game;

  private ProjectileTower tower;
  private Creep creep;
  private PImage sprite = assetManager.getImage("arrowProjectile");
  private float orientation = 0;

  public Projectile(ProjectileTower tower, Creep creep, Game game) {
    super(Utils.voidRectangle(SIZE));
    this.game = game;
    this.tower = tower;
    this.creep = creep;

    PVector towerCenter = tower.getCenter();
    setX(_centerTo(towerCenter.x, Tower.SIZE));
    setY(_centerTo(towerCenter.y, Tower.SIZE));

    this.game.register(this);
  }

  public void update() {
    PVector pos = getCenter();
    PVector creepPos = creep.getCenter();
    float creepWidth = creep.getBoundingBox().getWidth();
    float creepHeight = creep.getBoundingBox().getHeight();

    float dx = _centerTo(creepPos.x, creepWidth) - _centerTo(pos.x, Tower.SIZE);
    float dy = _centerTo(creepPos.y, creepHeight) - _centerTo(pos.y, Tower.SIZE);
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

  private float _centerTo(float targetX, float targetSize) {
    return Utils.centerTo(targetX, targetSize, SIZE);
  }
}