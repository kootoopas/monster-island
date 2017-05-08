class TextButton extends Button {
  public static final int WIDTH = 300;
  public static final int HEIGHT = 32;
  private static final color BACKGROUND = Utils.VERY_DARK_VIOLET;
  private static final color COLOR = Utils.PEPPERMINT;
  private static final color ACTIVE_COLOR = Utils.BANANA;

  private String text;

  public TextButton(int x, int y, String text, CWorld world) {
    super(new HRectangle(x, y, WIDTH, HEIGHT), world);
    this.text = text;
  }

  public void setText(String text) {
    this.text = text;
  }

  public void draw() {
    _drawBackground();

    _setHoverFill();
    _drawLeftBorder();
    _drawText();
  }

  private void _drawBackground() {
    fill(BACKGROUND);
    noStroke();
    _shape.draw();
  }

  private void _setHoverFill() {
    fill(_shape.contains(mouseX, mouseY)
            ? ACTIVE_COLOR
            : COLOR);
  }

  private void _drawLeftBorder() {
    rect(0, 0, 5, HEIGHT);
  }

  private void _drawText() {
    // Text is drawn in relation to _shape's origin.
    text(text, 22, 22);
  }
}
