abstract class TowerStats {

  int hitrate;
  int atk;

  public TowerStats(int hitrate, int atk) {
    this.hitrate = hitrate;
    this.atk = atk;
  }
}

class ArrowTowerStats extends TowerStats {

  public ArrowTowerStats() {
    super(400, 90);
  }
}

class IceTowerStats extends TowerStats {

  public IceTowerStats() {
    super(500, 40);
  }
}