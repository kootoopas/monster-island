static class Utils {
  public static final double SCALE = 1;

  public static int scale(int n) {
    return (int) Math.floor(n * Utils.SCALE);
  };
  
  static String readFile(String path) throws IOException {
    byte[] encoded = Files.readAllBytes(Paths.get(path));
    return new String(encoded, Charset.defaultCharset());
  }
}
