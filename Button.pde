class Button extends Being {
  public static final int HIDDEN = 0;
  public static final int VISIBLE = 1;
  
  protected CWorld world;

  public Button(HShape shape, CWorld world) {
    this(shape, VISIBLE, world);
  }

  public Button(HShape shape, int visibility, CWorld world) {
    super(shape);
    this.world = world;
    
    if (visibility == VISIBLE) {
      this.world.register(this);
      this.world.subscribe(this, POCodes.Button.LEFT);
    }
  }

  public void receive(MouseMessage msg) {
    if (msg.getAction() == POCodes.Click.PRESSED
            && _shape.contains(mouseX, mouseY)) {
      _onClick();
    }
  }

  /**
   * Override in subclasses to use.
   */
  protected void _onClick() {}
}
