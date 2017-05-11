class IceProjectile extends Projectile {

  public static final int SPD = 10;

  public IceProjectile(IceTower tower, Creep creep, Game game) {
    super(
            new ProjectileData(
                    assetManager.getImage("iceProjectile"),
                    SPD
            ),
            tower,
            creep,
            game
    );
  }

  protected void _onImpact() {
    game.delete(this);
    creep.induceFrostbite();
    tower.hit(creep);
  }
}