class Player {

  private static final int INITIAL_HP = 20;
  public static final int TOP_TEXT_MARGIN = 23;
  
  private Game game;
  
  private int hp = INITIAL_HP;
  private int gold;
  private TowerGroups towers;
  private Group<Guard> guards;
  
  Player(int initialGold, Game game) {
    this.gold = initialGold;
    this.game = game;
    this.towers = new TowerGroups(game);
    this.guards = new Group(game);
  }

  public TowerGroups getTowers() {
    return towers;
  }

  public Group<Guard> getGuards() {
    return guards;
  }

  public void drawStats() {

    fill(Utils.FADED_RED);
    _topText(hp + "HP", 10);
    
    fill(Utils.BANANA);
    _topText(gold + "G", 60);
  }
  
  public void spendGold(int cost) throws InsufficientGoldException {
    if (gold - cost < 0) {
      throw new InsufficientGoldException();
    }
    gold -= cost;
  }
  
  public void buyTower(int type, Node node) {
    try {
      node.assertVacancy();
      spendGold(TowerCost.calc(type));
    } catch (InsufficientGoldException e) {
      println("Can't buy that.");
      return;
    } catch (NodeIsOccupiedException e) {
      println("Node is occupied.");
      return;
    }

    switch (type) {
      case Tower.ARROW:
        new ArrowTower(type, node, this, game);
        break;
      case Tower.ICE:
        new IceTower(type, node, this, game);
        break;
      default:
        println("Type number " + type + " does not map to a valid tower type.");
    }

  }
  
  public void receiveDmg() {
    hp = hp - 1 > 0
            ? hp - 1
            : 0;
  }
  
  public boolean isAlive() {
    return hp > 0;
  }

  public int getHp() {
    return hp;
  }

  public void gainGold(int amount) {
    gold += amount;
  }

  private void _topText(String text, int x) {
    textSize(32);
    text(text, x, TOP_TEXT_MARGIN);
  }

  public void addToGuards(Guard guard) {
    guards.add(guard);
  }

  public void addToTowers(GuardTower tower) {
    towers.add(tower);
  }

  public void addToTowers(IceTower tower) {
    towers.add(tower);
  }

  public void addToTowers(ArrowTower tower) {
    towers.add(tower);
  }
}


class InsufficientGoldException extends Exception {}
