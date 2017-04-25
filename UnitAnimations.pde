class UnitAnimations {
  public static final int PEASANT_SHEET_I = 10;

  private Unit unit;
  private AnimatedSprite sprite;

  // FIXME: Move this to a place that runs once.
  private final Tileset unitSheet = assetManager.getSpritesheet("unitSheet");

  public UnitAnimations(Unit unit) {
    this.unit = unit;
    this.sprite = new AnimatedSprite();
    _setAnimations();
  }

  public PImage animate() {
    return sprite.animate();
  }

  private void _setAnimations() {
    sprite.addAnimation(new Animation(unitSheet.getRowOfTiles(PEASANT_SHEET_I), 100));
    sprite.setActiveAnimation(0);
  }

  private void _extractAnimations() {

  }
}