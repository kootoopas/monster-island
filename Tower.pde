abstract class Tower extends Being {
  public static final int MELEE = 0;
  public static final int ARROW = 1;
  public static final int MORTAR = 2;
    
  public static final int HITRATE = 400;
  public static final int RANGE = 130;
  
  protected Game game;
  protected Node node;
  
  protected int type;
  protected int lvl = 1;
  
  private color background;
  
  Tower(int type, Node node, Game game) {
    super(node.getShape());
    
    this.game = game;
    this.node = node;
    
    this.type = type;
    this.background = Utils.getTowerColor(type);
    
    _register();
  }
  
  void draw() {
    noStroke();
    fill(background);
    _shape.draw();
  }
  
  private void _register() {
    node.unregister();
    game.register(this);
  }
}


abstract class GuardTower extends Tower {

  public GuardTower(int type, Node node, Game game) {
    super(type, node, game);
  }
}




class ProjectileTower extends OffensiveTower {
  
  public static final int HITRATE = 800;
  public static final int ATK = 100;
  
  public ProjectileTower(int type, Node node, Game game) {
    super(type, node, game);
    this.combat = new ProjectileTowerCombat(this, game);
  }
  
  public void shoot(Creep creep) {
    combat.shoot(creep);
  }
}
