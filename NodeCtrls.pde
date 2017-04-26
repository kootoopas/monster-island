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
            new NodeBuyButton(
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
