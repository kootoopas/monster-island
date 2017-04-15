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

abstract class OffensiveTower extends Tower {

  protected TowerToCreepCombat combat;

  public OffensiveTower(int type, Node node, Game game) {
    super(type, node, game);
  }
  
  public void inflictDmg(Creep creep) {
    combat.inflictDmg(creep);
  }
  
  public boolean onCooldown() {
    return combat.onCooldown();
  }
}

class ProjectileTower extends OffensiveTower {
  
  public static final int HITRATE = 800;
  public static final int ATK = 100;
  
  public ProjectileTower(int type, Node node, Game game) {
    super(type, node, game);
    this.combat = new ProjectileTowerCombat(this);
  }
  
  public void shoot(Creep creep) {
    combat.registerShot();
    new Projectile(this, creep, game);
  }
}


class Projectile extends Being {
  
  private Game game;
  
  private ProjectileTower tower;
  private Creep creep;
  
  private int launchtime;
  
  public Projectile(ProjectileTower tower, Creep creep, Game game) {
    super(Utils.voidRectangle());
    this.game = game;
    this.tower = tower;
    this.creep = creep;
    
    this.launchtime = millis();
    this.game.register(this);
  }
  
  public void update() {
    if (millis() - launchtime > 200) {
      game.delete(this);
      tower.inflictDmg(creep);
    }
  }
  
  public void draw() {
    PVector towerPos = tower.getBoundingBox().getCenter();
    PVector creepPos = creep.getBoundingBox().getCenter();

    line(towerPos.x, towerPos.y, creepPos.x, creepPos.y);
  }
}



class TowerGroups {

  private Game game;
  
  public Group<Tower> all;
  public Group<ProjectileTower> projectile;
  public Group<GuardTower> guard;
  
  public TowerGroups(Game game) {
    this.game = game;
    
    this.all = new Group(game);
    this.projectile = new Group(game);
    this.guard = new Group(game);
  }
  
  public void add(ProjectileTower tower) {
    _addToAll(tower);
    projectile.add(tower);
  }
  
  public void add(GuardTower tower) {
    _addToAll(tower);
    guard.add(tower);
  }
  
  private void _addToAll(Tower tower) {
    all.add(tower);
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
