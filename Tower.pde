abstract class Tower extends CBeing {
  public static final int MELEE = 0;
  public static final int ARROW = 1;
  public static final int ICE = 2;

  public static final int SIZE = Node.SIZE;

  public static final String DIR = "towers";
    
  public static final int HITRATE = 400;
  public static final int RANGE = 130;

  public static final int Y_OFFSET = -49;
  
  protected Game game;
  protected Player player;
  protected Node node;
  
  protected int type;
  protected int lvl = 1;
  protected PImage sprite;
  
  private color background;
  
  Tower(int type, Node node, Player player, Game game) {
    super(node.getShape());
    
    this.game = game;
    this.player = player;
    this.node = node;
    
    this.type = type;
    this.sprite = _getSpriteByType(type);
  }
  
  void draw() {
    noStroke();
    image(sprite, 0, Y_OFFSET);
  }
  
  protected void _register() {
    node.unregister();
  }

  private PImage _getSpriteByType(int type) {
    switch (type) {
      case ARROW:
        return assetManager.getImage("arrowTower");
      case ICE:
        return assetManager.getImage("iceTower");
      default:
        return new PImage();
    }
  }
}