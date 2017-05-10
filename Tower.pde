abstract class Tower extends CBeing {

  public static final int MELEE = 0;
  public static final int ARROW = 1;
  public static final int ICE = 2;

  public static final int SIZE = Node.SIZE;

  public static final String DIR = "towers";

  public static final int RANGE = 130;

  public static final int Y_OFFSET = -49;
  
  protected Game game;
  protected Player player;
  protected Node node;
  
  protected int type;
  protected PImage sprite;
  protected int lvl = 1;
  protected TowerStats stats;

  private color background;
  
  Tower(int type, Node node, Player player, Game game) {
    super(node.getShape());
    
    this.game = game;
    this.player = player;
    this.node = node;
    
    this.type = type;
    _setTypeProps(type);
  }

  public int getType() {
    return type;
  }

  public TowerStats getStats() {
    return stats;
  }

  void draw() {
    noStroke();
    image(sprite, 0, Y_OFFSET);
  }
  
  protected void _register() {
    node.unregister();
  }

  private void _setTypeProps(int type) {
    switch (type) {
      case ARROW:
        sprite = assetManager.getImage("arrowTower");
        stats = new ArrowTowerStats();
        break;
      case ICE:
        sprite = assetManager.getImage("iceTower");
        stats = new IceTowerStats();
        break;
      default:
        sprite = assetManager.getImage("arrowTower");
        stats = new ArrowTowerStats();
        break;
    }
  }
}