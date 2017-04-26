class ShapeButton extends Button {

  private color backgroundColor;

  ShapeButton(HShape shape, color backgroundColor, CWorld world) {
    super(shape, world);
    this.backgroundColor = backgroundColor;
  }

  ShapeButton(HShape shape, color backgroundColor, int visibility, CWorld world) {
    super(shape, visibility, world);
    this.backgroundColor = backgroundColor;
  }

  void draw() {
    fill(backgroundColor);
    noStroke();
    _shape.draw();
  }
}
