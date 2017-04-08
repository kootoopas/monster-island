class Player {
  public static final int INITIAL_HP = 20;
  
  private int hp;
  private int gold;
  private ArrayList<Integer> towers;
  
  Player(int initialGold, Game game) {
    hp = INITIAL_HP;
    gold = initialGold;
    towers = new ArrayList();
  }
  
  public void drawStats() {
    fill(#ffffff);
    textSize(16);
    text("Gold: " + gold + "  HP: " + hp, 10, 21);
  }
  
  public void spendGold(int cost) throws InsufficientGoldException {
    if (gold - cost < 0) {
      throw new InsufficientGoldException();
    }
    gold -= cost;
  }
}

class InsufficientGoldException extends Exception {}
