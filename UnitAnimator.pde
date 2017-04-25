class UnitAnimator {

  public static final int UPWARDS_WALK_IDX = 0;
  public static final int HORIZONTAL_WALK_IDX = 1;
  public static final int DOWNWARDS_WALK_IDX = 2;
  public static final int UPWARDS_HIT_IDX = 3;
  public static final int HORIZONTAL_HIT_IDX = 4;
  public static final int DOWNWARDS_HIT_IDX = 5;

  /**
   * Number of sprites that each animation is composed of.
   */
  public static final int FRAMES_LENGTH = 4;
  public static final int MILLIS_PER_FRAME = 150;

  private Unit unit;
  private AnimatedSprite sprite;

  private final HashMap<Integer, Integer> typeToSpriteMap = _createTypeToSpriteMap();
  private final Tileset unitSheet = assetManager.getSpritesheet("unitSheet");

  public UnitAnimator(Unit unit) {
    this.unit = unit;
    this.sprite = new AnimatedSprite();
    _setAnimations();
    setActiveAnimation(DOWNWARDS_WALK_IDX);
  }

  public PImage animate() {
    return sprite.animate();
  }

  public void setActiveAnimation(int i) {
    sprite.setActiveAnimation(i);
  }

  /**
   * NOTE: Order of registration should always reflect IDXs.
   */
  private void _setAnimations() {
    sprite.addAnimation(new Animation(_extractUpwardsWalkcycle(), MILLIS_PER_FRAME));
    sprite.addAnimation(new Animation(_extractHorizontalWalkcycle(), MILLIS_PER_FRAME));
    sprite.addAnimation(new Animation(_extractDownwardsWalkcycle(), MILLIS_PER_FRAME));
  }

  private PImage[] _extractUpwardsWalkcycle() {
    PImage[] sprites = unitSheet.getRowOfTiles(_getSpriteIdx() + UPWARDS_WALK_IDX);
    return Arrays.copyOfRange(sprites, 0, FRAMES_LENGTH - 1);
  }

  private PImage[] _extractHorizontalWalkcycle() {
    PImage[] sprites = unitSheet.getRowOfTiles(_getSpriteIdx() + HORIZONTAL_WALK_IDX);
    return Arrays.copyOfRange(sprites, 0, FRAMES_LENGTH - 1);
  }

  private PImage[] _extractDownwardsWalkcycle() {
    PImage[] sprites = unitSheet.getRowOfTiles(_getSpriteIdx() + DOWNWARDS_WALK_IDX);
    return Arrays.copyOfRange(sprites, 0, FRAMES_LENGTH - 1);
  }

  /**
   * All animations' indexes map to unit sprites in data/units/spritesheet.
   */
  private HashMap<Integer, Integer> _createTypeToSpriteMap() {
    HashMap<Integer, Integer> map = new HashMap();
    map.put(UnitUtils.PEASANT, 10);
    map.put(UnitUtils.FOOTMAN, 3);
    return map;
  }

  private int _getSpriteIdx() {
    return typeToSpriteMap.get(unit.getType());
  }
}