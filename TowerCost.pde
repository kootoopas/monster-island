static class TowerCost {
  public static final int ARROW_BASE = 100;

  static int calc(int type) {
    return calc(type, 1);
  }

  static int calc(int type, int lvl) {
    // TODO: Move tower data on diff object. maybe parse json object containing their data? meta lvls power etc
    return ARROW_BASE;
  }
}
