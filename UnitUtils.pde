static class UnitUtils {
  public static final int WIDTH = 18;
  public static final int HEIGHT = 20;

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