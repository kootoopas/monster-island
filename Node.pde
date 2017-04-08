class Node extends Being implements MouseSubscriber {
  public static final int SIZE = 28;
  
  private Game game;
  private PostOffice po;
  
  private NodeCtrls ctrls;
  private boolean isHovered;
  private boolean isActive;
  
  Node(float x, float y, Game game) {
    super(new HRectangle(x - SIZE * 0.5, y - SIZE * 0.5, SIZE, SIZE));
    this.game = game;
    this.po = game.getPostOffice();
    
    this.ctrls = new NodeCtrls(this);
    this.isHovered = false;
    this.isActive = false;
    
    this.game.register(this);
    this.game.subscribe(this, POCodes.Button.LEFT);
  }
  
  void receive(MouseMessage m) {
    if (m.getAction() == POCodes.Click.PRESSED) {
      if (isHovered
          || isActive && po.isMouseInRegion(ctrls.getShape())) {
        isActive = true;
        game.register(ctrls);
      } else {
        isActive = false;
        game.delete(ctrls);
      }
    }
  }
  
  void update() {
    isHovered = po.isMouseInRegion(getShape());
  }
  
  void draw() {
    stroke(isHovered || isActive ? #00aa00 : #00dd00);
    
    fill(isActive ? #00bb00 : #00ff00);
    _shape.draw();
  }
  
//  _mouseIsIn
}

class NodeCtrls extends Being {
  private static final int SIZE = 96;
  
  private Node node;
  
  NodeCtrls(Node node) {
    super(new HRectangle(node.getX() - SIZE / 2 + Node.SIZE / 2, node.getY() - SIZE - Node.SIZE / 3, SIZE, SIZE));
    this.node = node;
  }
  
  void draw() {
    fill(Utils.VERY_DARK_VIOLET);
    _shape.draw();
  }
}
