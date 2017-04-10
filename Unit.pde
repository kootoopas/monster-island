abstract class Unit extends Being {

  protected CWorld world;
  
  protected int type;
  protected int family;
  protected Stats stats;
  protected int dmgReceipt;
  
  protected JSONObject data;

  Unit(int type, int family, PVector spawnpoint, CWorld world) {
    super(new HRectangle(spawnpoint.x - 8, spawnpoint.y - 10, 16, 20));
    this.world = world;
    this.family = family;
    this.type = type;
    
    _extractUnitData();
    this.stats = new Stats();
    this.dmgReceipt = 0;
    
    this.world.register(this);
//    println(this + " " + millis());
  }
  
  protected class Stats {
    public int hp;
    public int atk;
    public int hitrate;
    public int def;
    public String defType;
    public int spd;
    
    Stats() {
      this.hp = data.getInt("hp");
      this.atk = data.getInt("atk");
      this.hitrate = data.getInt("hitrate");
      this.def = data.getInt("def");
      this.defType = data.getString("defType");
      this.spd = data.getInt("spd");
    }
  }

  public Stats getStats() {
    return stats;
  }

  public void inflictDmg(int dmg) {
    dmgReceipt += dmg;
  }
  
  public boolean isAlive() {
    return stats.hp - dmgReceipt > 0;
  }
  
  public int getRemainingHp() {
    return stats.hp - dmgReceipt;
  }
  
  protected String getDataPath() {
    return Utils.pluralize(UnitUtils.familyToString(family)) + "/" + UnitUtils.typeToString(type);
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
  
  public void update() {
    setY(getY() - 2);
  }
  
  public void draw() {
    fill(Utils.FADED_RED);
    _shape.draw();
  }
  
  public String toString() {
    return UnitUtils.typeToString(type) + "(hp=" + getRemainingHp() + "/" + stats.hp + ")";
  }
}


class Creep extends Unit {
  Creep(int type, PVector spawnpoint, CWorld world) {
    super(type, UnitUtils.CREEP, spawnpoint, world);
  }
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
  
  public static String familyToString(int family) {
    switch(family) {
      case UnitUtils.CREEP: return "creep";
      case UnitUtils.GUARD: return "guard";
      default: return "creep";
    }
  }
}
