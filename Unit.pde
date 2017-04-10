abstract class Unit extends Being {

  protected CustomWorld world;
  
  protected int id;
  protected int type;
  protected Stats stats;
  protected int dmgReceipt;
  
  protected JSONObject data;

  Unit(int id, int type, PVector spawnpoint, CustomWorld world) {
    super(new HRectangle(spawnpoint.x - 8, spawnpoint.y - 10, 16, 20));
    this.world = world;
    this.type = type;
    this.id = id;
    
    _setUnitData();
    this.stats = new Stats();
    this.dmgReceipt = 0;
    
    this.world.register(this);
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
  
  protected String getDataPath() {
    return Utils.pluralize(typeToString()) + "/" + idToString(); 
  }
  
  private void _setUnitData() {
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
  
  public String idToString() {
    switch(id) {
      case UnitUtils.PEASANT: return "peasant";
      case UnitUtils.FOOTMAN: return "footman";
      default: return "peasant";
    }
  }
  
  public String typeToString() {
    switch(type) {
      case UnitUtils.CREEP: return "creep";
      case UnitUtils.GUARD: return "guard";
      default: return "creep";
    }
  }
  
  public void draw() {
    fill(Utils.FADED_RED);
    _shape.draw();
  }
}


class Creep extends Unit {
  Creep(int id, PVector spawnpoint, CustomWorld world) {
    super(id, UnitUtils.CREEP, spawnpoint, world);
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
}
