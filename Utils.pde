static class Utils {
  public static final color VERY_DARK_VIOLET = #17111D;
  public static final color FADED_RED = #D3494E;
  public static final color BANANA = #E3CF57;
  
  public static final double SCALE = 1;

  public static int scale(int n) {
    return (int) Math.floor(n * Utils.SCALE);
  };
  
  static String readFile(String path) throws IOException {
    byte[] encoded = Files.readAllBytes(Paths.get(path));
    return new String(encoded, Charset.defaultCharset());
  }
}
