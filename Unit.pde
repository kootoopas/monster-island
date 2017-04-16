abstract class Unit extends Being {

  protected Game game;
  
  protected int type;
  protected int taxonomy;
  protected Stats stats;
  protected Movement movement;
  protected int dmgReceipt = 0;
  
  protected JSONObject data;

  Unit(int type, int taxonomy, PVector spawnpoint, Game game) {
    super(new HRectangle(spawnpoint.x - 8, spawnpoint.y - 10, 16, 20));
    this.game = game;
    this.taxonomy = taxonomy;
    this.type = type;
    
    _extractUnitData();
    this.stats = new Stats();    
    
    this.game.register(this);
//    println(this + " " + millis());
  }
  
  protected class Stats {
    public int hp;
    public int atk;
    public int hitrate;
    public int def;
    public String defType;
    public float spd;
    
    Stats() {
      this.hp = data.getInt("hp");
      this.atk = data.getInt("atk");
      this.hitrate = data.getInt("hitrate");
      this.def = data.getInt("def");
      this.defType = data.getString("defType");
      this.spd = data.getFloat("spd");
    }
  }

  public Stats getStats() {
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
    fill(Utils.FADED_RED);
    _shape.draw();
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
    game.rewardPlayer(loot);
  }
}


class UnitMovement implements Movement {
  
  private Unit unit;
  protected int status = Movement.STILL;
  protected float spd;
  protected PVector dest;
  private boolean destReached = false;

  public UnitMovement(Unit unit) {
    this.unit = unit;
    this.spd = unit.getStats().spd;
    this.dest = unit.getPosition();
  }

  public void update() {
    if (destReached()) return;
    
    float dx = dest.x - unit.getX();
    float dy = dest.y - unit.getY();
    float dist = sqrt(dx * dx + dy * dy);

    if (dist > spd) {
      float ratio = spd / dist;
      float xMove = ratio * dx;
      float yMove = ratio * dy;
      unit.setX(xMove + unit.getX());  
      unit.setY(yMove + unit.getY());
    } else {
      unit.setPosition(dest);
      destReached = true;
    }
    
    // IDEA: Berserk shaky movement mode (works for non distance checking movement though :/)
    //       if unit.getX() > dest.x is removed the unit moves in a shaky freaky way.
  }
  
  public void setDest(PVector nextDest) {
    if (!dest.equals(nextDest)) {
      destReached = false;
      dest = nextDest;
    }
  }
  
  public boolean destReached() {
    return destReached;
  }
}


class CreepMovement extends UnitMovement {
  
  // Dest is initially set to 2nd point of path. (since every creep moves from there first)
  private Iterator pathIter;
  private Creep creep;
  
  public CreepMovement(Creep creep, Path path) {
    super((Unit) creep);
    this.creep = creep;
    this.pathIter = path.iterator();
    
    // Skip spawnpoint.
    this.pathIter.next();
    
    this.setDest((PVector) pathIter.next());
  }

  public void update() {
    if (destReached()) {
      if (pathIter.hasNext()) {
        setDest((PVector) pathIter.next());
      } else {
        _handleGuardpointReach();
      }
    }

    super.update();
  }
  
  private void _handleGuardpointReach() {
    creep.dmgPlayer();
    creep.unregister();
  }
}


interface Movement {  
  static final int STILL = 0;
  static final int MOVING = 1;
  static final int INTERRUPTED = 2;
  
  void setDest(PVector nextDest);
  boolean destReached();
  void update();
}


static class UnitUtils {
  public static final int GUARD = 0;
  public static final int CREEP = 1;
  
  public static final int PEASANT = 100;
  public static final int FOOTMAN = 101;
  
  public static final String DIR = "units";
  public static final String GUARDS_SUBDIR = "guards";
  public static final String CREEPS_SUBDIR = "creeps";
  public static final String DATAFILE = "data.json";
  
  public static String typeToString(int type) {
    switch(type) {
      case UnitUtils.PEASANT: return "peasant";
      case UnitUtils.FOOTMAN: return "footman";
      default: return "peasant";
    }
  }
  
  public static int stringToType(String str) {
    if (str.equals("peasant")) {
      return UnitUtils.PEASANT;
    } else if (str.equals("footman")) {
      return UnitUtils.FOOTMAN;
    } else {
      return UnitUtils.PEASANT;
    }
  }
  
  public static String taxonomyToString(int taxonomy) {
    switch(taxonomy) {
      case UnitUtils.CREEP: return "creep";
      case UnitUtils.GUARD: return "guard";
      default: return "creep";
    }
  }
}
