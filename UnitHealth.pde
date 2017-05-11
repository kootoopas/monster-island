class UnitHealth {
  public static final int NORMAL = 0;
  public static final int FROSTBITTEN = 1;

  public static final float FROSTBITE_SPD = 0.3;

  private UnitStats stats;

  private int dmgReceipt = 0;
  private int status = NORMAL;
  private int indctiontime;

  public UnitHealth(Unit unit) {
    this.stats = unit.getStats();
  }

  public int getRemainingHp() {
    return stats.hp - dmgReceipt;
  }

  public boolean isAlive() {
    return stats.hp - dmgReceipt > 0;
  }

  public void receiveDmg(int dmg) {
    dmgReceipt = dmgReceipt + dmg;
  }

  public void induceFrostbite() {
    status = FROSTBITTEN;
    indctiontime = millis();
  }

  public void liftFrostbite() {
    if (status == FROSTBITTEN) {
      status = NORMAL;
    }
  }

  public boolean isFrostbitten() {
    return status == FROSTBITTEN
            && millis() - indctiontime < 3000;
  }
}