class Unit extends CBeing {

  protected Game game;

  protected int type;
  protected int taxonomy;
  protected UnitStats stats;
  protected Movement movement;
  protected UnitAnimations anims;
  protected int dmgReceipt = 0;

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
    this.anims = new UnitAnimations(this);

    this.game.register(this);
  }

  public UnitStats getStats() {
    return stats;
  }

  public void receiveDmg(int dmg) {
    dmgReceipt += dmg;
  }
  
  public boolean isAlive() {
    return stats.hp - dmgReceipt > 0;
  }
  
  public int getRemainingHp() {
    return stats.hp - dmgReceipt;
  }
  
  protected String getDataPath() {
    return Utils.pluralize(UnitUtils.taxonomyToString(taxonomy)) + "/" + UnitUtils.typeToString(type);
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
  
  public void setDest(PVector dest) {
    movement.setDest(dest);
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
    image(anims.animate(), 0, 0); // draw the current animation frame
  }
  
  public void unregister() {
    game.delete(this);
  }
  
  public String toString() {
    return UnitUtils.typeToString(type) + "(hp=" + getRemainingHp() + "/" + stats.hp + ")";
  }

  protected void _preDeath() {}
}


class Creep extends Unit {

  private int loot;

  Creep(int type, Path path, Game game) {
    super(type, UnitUtils.CREEP, path.getSpawnpoint(), game);
    this.movement = new CreepMovement(this, path);
    this.loot = data.getInt("loot");
  }
  
  public void dmgPlayer() {
    game.dmgPlayer();
  }

  protected void _preDeath() {
    new PopupText("+" + loot, getPosition(), game);
    game.rewardPlayer(loot);
  }
}
