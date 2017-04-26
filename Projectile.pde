class Projectile extends Being {

  private Game game;

  private ProjectileTower tower;
  private Creep creep;

  private int launchtime;

  public Projectile(ProjectileTower tower, Creep creep, Game game) {
    super(Utils.voidRectangle());
    this.game = game;
    this.tower = tower;
    this.creep = creep;

    this.launchtime = millis();
    this.game.register(this);
  }

  public void update() {
    if (millis() - launchtime > 150) {
      game.delete(this);
      tower.hit(creep);
    }
  }

  public void draw() {
    PVector towerPos = tower.getBoundingBox().getCenter();
    PVector creepPos = creep.getBoundingBox().getCenter();

    line(towerPos.x, towerPos.y, creepPos.x, creepPos.y);
  }
}