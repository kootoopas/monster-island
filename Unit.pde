class Unit extends CBeing {

  protected Game game;

  protected int type;
  protected int taxonomy;
  protected UnitStats stats;
  protected Movement movement;
  protected UnitAnimator anim;
  protected UnitHealth health;
  protected UnitHpBar hpBar;

  protected JSONObject data;

  Unit(int type, int taxonomy, PVector spawnpoint, Game game) {
    super(new HRectangle(
            spawnpoint.x - UnitUtils.WIDTH * 0.5,
            spawnpoint.y - UnitUtils.HEIGHT * 0.5,
            UnitUtils.WIDTH,
            UnitUtils.HEIGHT
    ));

    this.game = game;
    this.taxonomy = taxonomy;
    this.type = type;

    _extractUnitData();
    this.stats = new UnitStats(data);

    this.movement = new UnitMovement(this);
    this.anim = new UnitAnimator(this);
    this.health = new UnitHealth(this);

    this.hpBar = new UnitHpBar(this, game);
    this.game.register(this);
  }

  public int getType() {
    return type;
  }

  public int getDirection() {
    return movement.getDirection();
  }

  public UnitStats getStats() {
    return stats;
  }

  public void receiveDmg(int dmg) {
    health.receiveDmg(dmg);
  }
  
  public boolean isAlive() {
    return health.isAlive();
  }

  public void induceFrostbite() {
    health.induceFrostbite();
  }

  public boolean isFrostbitten() {
    return health.isFrostbitten();
  }

  public int getRemainingHp() {
    return health.getRemainingHp();
  }
  
  protected String getDataPath() {
    return Utils.pluralize(UnitUtils.taxonomyToString(taxonomy)) + "/" + UnitUtils.typeToString(type);
  }

  public UnitAnimator getAnimator() {
    return anim;
  }

  public Movement getMovement() {
    return movement;
  }

  private void _extractUnitData() {
    try {
      data = parseJSONObject(
        Utils.readFile(
          dataPath(UnitUtils.DIR + "/" + getDataPath() + "/" + UnitUtils.DATAFILE)
        )
      );
    } catch(IOException e) {
      println(e);
    }
  }
  
  public void moveTo(PVector dest) {
    movement.moveTo(dest);
  }
  
  public boolean destReached() {
    return movement.destReached();
  }

  public void update() {
    if (isAlive()) {
      movement.update();    
    } else {
      _preDeath();
      this.unregister();
    }
  }
  
  public void draw() {
    image(anim.animate(), 0, 0); // draw the current animation frame
  }
  
  public void unregister() {
    game.delete(this);
    game.delete(hpBar);
  }
  
  public String toString() {
    return UnitUtils.typeToString(type) + "(hp=" + getRemainingHp() + "/" + stats.hp + ")";
  }

  protected void _preDeath() {}
}
