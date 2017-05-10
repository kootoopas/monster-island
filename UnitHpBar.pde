class UnitHpBar extends CBeing {

  private int Y_OFFSET = -3;

  private Game game;
  private Unit unit;

  public UnitHpBar(Unit unit, Game game) {
    super(unit.getBoundingBox());
    this.game = game;
    this.unit = unit;

    game.register(this);
  }

  public void update() {
    if (!unit.isAlive()) {
      game.delete(this);
    }
  }

  public void draw() {
    _drawMax();
    _drawRemaining();
  }

  private void _drawRemaining() {
    float width = (float) Math.ceil(unit.getRemainingHp() * unit.getWidth() / unit.getStats().hp);
    if (width < 0) {
      width = 0;
    }

    noStroke();
    fill(Utils.FADED_RED);
    rect(0, Y_OFFSET, width, 3);
  }

  private void _drawMax() {
    stroke(Utils.VERY_DARK_VIOLET);
    strokeWeight(2);
    fill(Utils.VERY_DARK_VIOLET);
    rect(0, Y_OFFSET, unit.getWidth(), 3);
  }
}