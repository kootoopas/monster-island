class Player {
  private static final int INITIAL_HP = 20;
  public static final int TOP_TEXT_MARGIN = 21;
  
  private Game game;
  
  private int hp = INITIAL_HP;
  private int gold;
  private ArrayList<Tower> towers = new ArrayList();
  
  Player(int initialGold, Game game) {
    this.gold = initialGold;
    this.game = game;
  }
  
  public void drawStats() {
    PFont font = createFont("", 16);
    
    fill(Utils.FADED_RED);
    textFont(font);
    _topText(hp + "HP", 10);
    
    fill(Utils.BANANA);
    textFont(font);
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
    
  }
  
  private void _topText(String text, int x) {
    text(text, x, TOP_TEXT_MARGIN);
  }
}


class InsufficientGoldException extends Exception {}

