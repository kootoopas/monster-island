class PopupText extends Being {

  public static final int WIDTH = 64;
  public static final int HEIGHT = 28;

  public static final int LIFETIME = 600;
  public static final int MAX_ALPHA = 255;

  protected color SHADOW_COLOR = Utils.VERY_DARK_VIOLET;

  private CWorld world;

  private String text;
  private int spawntime;
  private float alpha = 255;
  protected color textColor = Utils.BANANA;

  public PopupText(String text, PVector pos, CWorld world) {
    super(
            new HRectangle(
                    pos.x - WIDTH * 0.5,
                    pos.y - HEIGHT * 0.75,
                    WIDTH,
                    HEIGHT
            )
    );
    this.world = world;
    this.text = text;

    this.spawntime = millis();
    this.world.register(this);
  }

  public void update() {
    int dSpawntime = millis() - spawntime;

    if (dSpawntime < LIFETIME) {
      setY(getY() - 0.8);
      _fadeOut(dSpawntime, LIFETIME);
    } else {
      world.delete(this);
    }
  }

  private void _fadeOut(int currtime, int endtime) {
    alpha = MAX_ALPHA - currtime * MAX_ALPHA / endtime;
  }

  public void draw() {
    noFill();
    noStroke();
    _shape.draw();
    _drawShadow();
    _drawText();
  }

  private void _drawShadow() {
    fill(SHADOW_COLOR, alpha);
    textSize(32);
    text(text, WIDTH * 0.4, 1);
  }

  private void _drawText() {
    fill(textColor, alpha);
    textSize(32);
    text(text, WIDTH * 0.4, 0);
  }
}

