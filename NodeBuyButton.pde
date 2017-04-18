class NodeBuyButton extends ShapeButton {
  private int type;
  private Node node;
  private Game game;

  NodeBuyButton(HShape shape, int type, Node node, Game game) {
    super(shape, Utils.getTowerColor(type), Button.HIDDEN, (CWorld) game);
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
