static class TowerCost {
  public static final int ARROW_BASE = 100;
  public static final int ICE_BASE = 120;

  static int calc(int type) {
    return calc(type, 1);
  }

  static int calc(int type, int lvl) {
    // TODO: Move tower data on diff object. maybe parse json object containing their data? meta lvls power etc
    switch (type) {
      case Tower.ARROW:
        return ARROW_BASE * lvl;
      case Tower.ICE:
        return ICE_BASE * lvl;
      default:
        return ARROW_BASE * lvl;
    }
  }
}
