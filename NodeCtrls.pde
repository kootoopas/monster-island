class NodeCtrls extends Being {
  private static final int SIZE = 48;

  private Game game;

  private Node node;
  private ArrayList<Button> btns;

  NodeCtrls(Node node, Game game) {
    super(NodeCtrlsUtils._calcRectangle(node));
    this.node = node;
    this.game = game;

    this.btns = new ArrayList();
    _addBtns();
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

  private void _addBtns() {
    btns.add(
            new NodeBuyButton(
                    Utils.fitIn(getBoundingBox(), 3),
                    Tower.ARROW,
                    node,
                    game
            )
    );
  }

}
