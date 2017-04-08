class Player {
  private static final int INITIAL_HP = 20;
  public static final int TOP_TEXT_MARGIN = 21;
  
  private Game game;
  
  private int hp;
  private int gold;
  private ArrayList<Tower> towers;
  
  Player(int initialGold, Game game) {
    this.hp = INITIAL_HP;
    this.gold = initialGold;
    this.towers = new ArrayList();
    this.game = game;
  }
  
  public void drawStats() {
    fill(Utils.FADED_RED);
    textSize(16);
    _topText(String.valueOf(hp) + "HP", 10);
    
    fill(Utils.BANANA);
    textSize(16);
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
    
    Tower tower = new Tower(type, node, game);
    towers.add(tower);
    node.setTower(tower);
    node.deactivate();
    
  }
  
  private void _topText(String text, int x) {
    text(text, x, TOP_TEXT_MARGIN);
  }
}


class InsufficientGoldException extends Exception {}

