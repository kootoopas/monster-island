class Player {
  private static final int INITIAL_HP = 20;
  public static final int TOP_TEXT_MARGIN = 21;
  
  private int hp;
  private int gold;
  private ArrayList<Integer> towers;
  
  Player(int initialGold, Game game) {
    hp = INITIAL_HP;
    gold = initialGold;
    towers = new ArrayList();
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
  
  private void _topText(String text, int x) {
    text(text, x, TOP_TEXT_MARGIN);
  }
}

class InsufficientGoldException extends Exception {}
