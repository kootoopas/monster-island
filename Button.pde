import hermes.Being;
import hermes.Hermes;
import hermes.hshape.HRectangle;
import hermes.postoffice.MouseMessage;
import hermes.postoffice.POCodes;

class Button extends Being {
  public static final int HIDDEN = 0;
  public static final int VISIBLE = 1;
  
  private CustomWorld world;

  public Button(HShape shape, CustomWorld world) {
    this(shape, VISIBLE, world);
  }

  public Button(HShape shape, int visibility, CustomWorld world) {
    super(shape);
    this.world = world;
    
    if (visibility == VISIBLE) {
      this.world.register(this);
    }
  }

//  public void receive(MouseMessage msg) {
//    if (msg.getAction() == POCodes.Click.PRESSED) {
//      world.handleEvent((Being) this);
//    }
//  }
}

class ShapeButton extends Button {

  private color backgroundColor;

  ShapeButton(HShape shape, color backgroundColor, CustomWorld world) {
    super(shape, world);
    this.backgroundColor = backgroundColor;
  }

  ShapeButton(HShape shape, color backgroundColor, int visibility, CustomWorld world) {
    super(shape, visibility, world);
    this.backgroundColor = backgroundColor;
  }

  void draw() {
    fill(backgroundColor);
    noStroke();
    _shape.draw();
  }
}

class TextButton extends Button {
  public static final int WIDTH = 300;
  public static final int HEIGHT = 50;
  private static final color BACKGROUND = Utils.VERY_DARK_VIOLET;
  private static final color COLOR = #ffffff;
  private static final color ACTIVE_COLOR = #fff700;

  private String text;

  public TextButton(int x, int y, String text, CustomWorld world) {
    super(new HRectangle(x, y, WIDTH, HEIGHT), world);
    this.text = text;
  }

  public void setText(String text) {
    this.text = text;
  }

  public void draw() {
    fill(BACKGROUND);
    noStroke();
    _shape.draw();

    textSize(16);
    fill(_shape.contains(mouseX, mouseY)
            ? ACTIVE_COLOR
            : COLOR);
    text(text, 50, 20); //text is drawn in relation to the shapes origin.

  }
}
