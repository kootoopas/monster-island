class UnitStats {
  public int hp;
  public int atk;
  public int hitrate;
  public int def;
  public String defType;
  public float spd;

  public UnitStats(JSONObject data) {
    this.hp = data.getInt("hp");
    this.atk = data.getInt("atk");
    this.hitrate = data.getInt("hitrate");
    this.def = data.getInt("def");
    this.defType = data.getString("defType");
    this.spd = data.getFloat("spd");
  }
}