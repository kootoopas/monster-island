class ArrowProjectile extends Projectile {

  public static final int SPD = 8;

  public ArrowProjectile(ArrowTower tower, Creep creep, Game game) {
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
}