class Tower extends Being {
  public static final int MELEE = 0;
  public static final int ARROW = 1;
  public static final int MORTAR = 2;
    
  public static final int HITRATE = 400;
  public static final int RANGE = 200;
  
  private Game game;
  private Node node;
  private int type;
  private color background;
  
  Tower(int type, Node node, Game game) {
    super(node.getShape());
    
    this.game = game;
    this.node = node;
    this.type = type;
    this.background = Utils.getTowerColor(type);
    
    this.game.delete(node);
    this.node.getCtrls().hide();
    this.game.register(this);
  }
  
  void draw() {
    noStroke();
    fill(background);
    _shape.draw();
  }
}

static class TowerCost {
  public static final int ARROW_BASE = 100;

  static int calc(int type) {
    return calc(type, 1);
  }
  
  static int calc(int type, int lvl) {
    // TODO: Move tower data on diff object. maybe parse json object containing their data? meta lvls power etc
    return ARROW_BASE;
  }
}
