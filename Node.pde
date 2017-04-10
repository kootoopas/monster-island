class Node extends Being {
  public static final int SIZE = 28;
  
  private Game game;
  private PostOffice po;
  
  private Tower tower;
  
  private NodeCtrls ctrls;
  private boolean hovered;
  private boolean active;
  
  Node(float x, float y, Game game) {
    super(new HRectangle(x - SIZE * 0.5, y - SIZE * 0.5, SIZE, SIZE));
    this.game = game;
    this.po = game.getPostOffice();
    
    this.tower = null;
    
    this.ctrls = new NodeCtrls(this, game);
    this.hovered = false;
    this.active = false;
    
    this.game.register(this);
    this.game.subscribe(this, POCodes.Button.LEFT);
  }
  
  void receive(MouseMessage m) {
    if (m.getAction() == POCodes.Click.PRESSED) {
      if (hovered
          || active && po.isMouseInRegion(ctrls.getShape())) {
        ctrls.show();
        activate();
      } else {
        deactivate();
      }
    }
  }
  
  void update() {
    hovered = po.isMouseInRegion(getShape());
  }
  
  void draw() {
    stroke(hovered || active ? #00aa00 : #00dd00);
    
    fill(active ? #00bb00 : #00ff00);
    _shape.draw();
  }
  
  public void setTower(Tower tower) {
    this.tower = tower;
  }
  
  public void assertVacancy() throws NodeIsOccupiedException {
    if (tower instanceof Tower) {
      throw new NodeIsOccupiedException();
    }
  }
  
  public NodeCtrls getCtrls() {
    return ctrls;
  }
  
  public boolean isActive() {
    return active;
  }
  
  public void activate() {
    ctrls.show();
    active = true;
  }
  
  public void deactivate() {
    ctrls.hide();
    active = false;
  }
  
  public void unregister() {
    game.delete(this);
    deactivate();
  }
}


class NodeCtrls extends Being {
  private static final int SIZE = 48;
  
  private Game game;
  
  private Node node;
  private ArrayList<Button> btns;
  
  NodeCtrls(Node node, Game game) {
    super(new HRectangle(node.getX() - SIZE / 2 + Node.SIZE / 2, node.getY() - SIZE - Node.SIZE / 3, SIZE, SIZE));
    this.node = node;
    this.game = game;
    
    this.btns = new ArrayList();
    this.btns.add(
      new BuyButton(
        Utils.fitIn(this.getBoundingBox(), 3),
        Tower.ARROW,
        node,
        this.game
      )
    );
  }
  
  void draw() {
    noStroke();
    fill(Utils.VERY_DARK_VIOLET);
    _shape.draw();
  }
  
  public void show() {
    game.register(this);

    for (Button btn : btns) {
      game.register(btn);
    }
  }
  
  public void hide() {
    // Makes hide (delete) run only for the active node.
    if (!node.isActive()) return;
    
    game.delete(this);

    for (Button btn : btns) {
      game.delete(btn);
    }
  }
}


class BuyButton extends ShapeButton {
  private int type;
  private Node node;
  private Game game;
  
  BuyButton(HShape shape, int type, Node node, Game game) {
    super(shape, Utils.getTowerColor(type), Button.HIDDEN, (CustomWorld) game);
    this.type = type;
    this.node = node;
    this.game = game;
    
    this.game.subscribe(this, POCodes.Button.LEFT);
  }
  
  public void receive(MouseMessage msg) {
    if (msg.getAction() == POCodes.Click.PRESSED
        && node.isActive()
        && _shape.contains(mouseX, mouseY)) {
      game.buyTower(type, node);
    }
  }
}


class NodeIsOccupiedException extends Exception {}
