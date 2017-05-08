import java.nio.charset.*;

static class Utils {
  // From dawnbringer's pallete: http://pixeljoint.com/forum/forum_posts.asp?TID=12795
  public static final color VERY_DARK_VIOLET = #17111D;
  public static final color FADED_RED = #D3494E;
  public static final color BANANA = #E3CF57;
  public static final color PEPPERMINT = #D7E7D0;
  public static final color INDIGO = #5D76CB;
  
  public static final double SCALE = 1;

  public static int scale(int n) {
    return (int) Math.floor(n * Utils.SCALE);
  };

  public static HRectangle fitIn(HRectangle box, int padding) {
    PVector pos = box.getPosition();
    return new HRectangle(
            pos.x + padding,
            pos.y + padding,
            box.getWidth() - padding * 2,
            box.getHeight() - padding * 2
    );
  }

  public static HRectangle fitIn(HRectangle box, int padding, int offset, int buttonCount) {
    int additionalLeftPadding = offset == 1
            ? 0
            : padding;

    PVector pos = box.getPosition();
    float width = box.getWidth() / buttonCount - padding * 2;
    return new HRectangle(
            // 4 points
            pos.x + width * (offset - 1) + padding + additionalLeftPadding * 2,
            pos.y + padding,
            width,
            box.getHeight() - padding * 2
    );
  }

  public static String readFile(String path) throws IOException {
    byte[] encoded = Files.readAllBytes(Paths.get(path));
    return new String(encoded, Charset.defaultCharset());
  }
  
  public static color getTowerColor(int type) {
    switch (type) {
      case Tower.ARROW: return Utils.BANANA;
      case Tower.MELEE: return Utils.INDIGO;
      default: return Utils.BANANA;
    }
  }
  
  public static String pluralize(String word) {
    return word + "s";
  }
  
  public static int millisToSecs(int millis) {
    return (int) (millis * .001);
  }
  
  public static int secsToMillis(int secs) {
    return secs * 1000;
  }
  
  public static HRectangle voidRectangle() {
    return new HRectangle(0, 0, 0, 0);
  }
}
