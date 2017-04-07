class Node extends Being {
  public static final int SIZE = 28;
  
  Node(float x, float y, World world) {
    super(new HRectangle(x - SIZE * 0.5, y - SIZE * 0.5, SIZE, SIZE));
    world.register(this);
  }
  
  void draw() {
    stroke(#00dd00);
    fill(#00ff00);
    _shape.draw();
  }
}
