class Node extends Being {
  public static final int SIZE = 50;
  
  private Game game;
  private PostOffice po;
  
  private Tower tower = null;
  
  private NodeCtrls ctrls;
  private boolean hovered = false;
  private boolean active = false;
  
  Node(float x, float y, Game game) {
    super(new HRectangle(x - SIZE * 0.5, y - SIZE * 0.5, SIZE, SIZE));
    this.game = game;
    this.po = game.getPostOffice();
    
    this.ctrls = new NodeCtrls(this, game);
    
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
    stroke(hovered || active
            ? #00aa00
            : #00dd00
    );
    
    fill(active
            ? #00bb00
            : #00ff00
    );
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

class NodeIsOccupiedException extends Exception {}
