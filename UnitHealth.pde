class UnitHealth {
  public static final int NORMAL = 0;
  public static final int FROSTBITTEN = 1;

  public static final float FROSTBITE_SPD = .8f;

  private UnitStats stats;
  private Movement movement;

  private int dmgReceipt = 0;
  private int status = NORMAL;

  public UnitHealth(Unit unit) {
    this.stats = unit.getStats();
    this.movement = unit.getMovement();
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
    movement.setSpd(stats.spd * FROSTBITE_SPD);
  }

  public void liftFrostbite() {
    if (status == FROSTBITTEN) {
      status = NORMAL;
      movement.setSpd(stats.spd / FROSTBITE_SPD);
    }
  }
}