abstract class Tower extends CBeing {
  public static final int MELEE = 0;
  public static final int ARROW = 1;
  public static final int MORTAR = 2;
    
  public static final int HITRATE = 400;
  public static final int RANGE = 130;
  
  protected Game game;
  protected Player player;
  protected Node node;
  
  protected int type;
  protected int lvl = 1;
  
  private color background;
  
  Tower(int type, Node node, Player player, Game game) {
    super(node.getShape());
    
    this.game = game;
    this.player = player;
    this.node = node;
    
    this.type = type;
    this.background = Utils.getTowerColor(type);
  }
  
  void draw() {
    noStroke();
    fill(background);
    _shape.draw();
  }
  
  protected void _register() {
    node.unregister();
  }
}