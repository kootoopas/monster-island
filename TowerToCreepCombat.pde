interface TowerToCreepCombat {
  void shoot(Creep creep);
  void registerShot();
  void hit(Creep creep);
  boolean onCooldown();
}
