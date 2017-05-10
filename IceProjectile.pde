class IceProjectile extends Projectile {

  public static final int SPD = 10;

  public IceProjectile(ProjectileTower tower, Creep creep, Game game) {
    super(
            new ProjectileData(
                    assetManager.getImage("arrowProjectile"),
                    SPD
            ),
            tower,
            creep,
            game
    );
  }

  protected void _onImpact() {
    game.delete(this);
    tower.hit(creep);
  }
}