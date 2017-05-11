abstract class Projectile extends CBeing {

  public static final int SIZE = 24;

  protected Game game;

  protected ProjectileTower tower;
  protected Creep creep;
  protected PImage sprite;
  protected float orientation = 0;
  protected float spd;

  public Projectile(ProjectileData data, ProjectileTower tower, Creep creep, Game game) {
    super(
            new HRectangle(
                    tower.getCenter().x,
                    tower.getCenter().y + Tower.Y_OFFSET * 0.5,
                    SIZE,
                    SIZE
            )
    );
    this.game = game;
    this.tower = tower;
    this.creep = creep;

    this.sprite = data.sprite;
    this.spd = data.spd;

    this.game.register(this);
  }

  public void update() {
    PVector pos = getPosition();
    PVector creepPos = creep.getCenter();

    float dx = creepPos.x - pos.x;
    float dy = creepPos.y - pos.y;
    float dist = sqrt(dx * dx + dy * dy);

    if (dist > spd) {
      float ratio = spd / dist;
      float xMove = ratio * dx;
      float yMove = ratio * dy;

      setX(getX() + xMove);
      setY(getY() + yMove);
      _orient(dx, dy);
    } else {
      _onImpact();
    }
  }

  private void _orient(float dx, float dy) {
    orientation = atan2(dy, dx);
  }

  protected void _onImpact() {
    game.delete(this);
    tower.hit(creep);
  }

  public void draw() {
    rotate(orientation - PI - PI / 4);
    image(sprite, 0, 0);
  }
}