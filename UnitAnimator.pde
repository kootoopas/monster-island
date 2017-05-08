class UnitAnimator {

  public static final int UPWARDS_IDLE_IDX = 0;
  public static final int HORIZONTAL_IDLE_IDX = 1;
  public static final int DOWNWARDS_IDLE_IDX = 2;

  public static final int UPWARDS_WALK_IDX = 3;
  public static final int HORIZONTAL_WALK_IDX = 4;
  public static final int DOWNWARDS_WALK_IDX = 5;

  public static final int UPWARDS_HIT_IDX = 3;
  public static final int HORIZONTAL_HIT_IDX = 4;
  public static final int DOWNWARDS_HIT_IDX = 5;

  public static final int WALK_TO_IDLE_IDX_DIFF = 3;

  /**
   * Number of sprites that each animation is composed of.
   */
  public static final int WALK_FRAMES_LENGTH = 3;
  public static final int MILLIS_PER_FRAME = 150;

  private Unit unit;
  private CAnimatedSprite sprite;

  private final HashMap<Integer, Integer> typeToSpriteMap = _buildTypeToSpriteMap();
  private final Tileset unitSheet = assetManager.getSpritesheet("unitSheet");

  public UnitAnimator(Unit unit) {
    this.unit = unit;
    this.sprite = new CAnimatedSprite();
    _setAnimations();
    setActiveAnimation(HORIZONTAL_WALK_IDX);
  }

  public PImage animate() {
    if (unit.getDirection() == UnitMovement.LEFT) {
      // Flip sprite.
      scale(-1,1);
      translate(-UnitUtils.WIDTH, 0);
    }

    return sprite.animate();
  }

  public void setActiveAnimation(int i) {
    sprite.setActiveAnimation(i);
  }

  public void setIdle() {
//    println(sprite.getActiveAnimationIndex());
    sprite.setActiveAnimation(sprite.getActiveAnimationIndex());
  }

  /**
   * NOTE: Order of registration matters. It should always reflect IDXs.
   */
  private void _setAnimations() {
    sprite.addAnimation(new Animation(_buildUpwardsIdle(), MILLIS_PER_FRAME));
    sprite.addAnimation(new Animation(_buildHorizontalIdle(), MILLIS_PER_FRAME));
    sprite.addAnimation(new Animation(_buildDownwardsIdle(), MILLIS_PER_FRAME));
    
    sprite.addAnimation(new Animation(_buildUpwardsWalkcycle(), MILLIS_PER_FRAME));
    sprite.addAnimation(new Animation(_buildHorizontalWalkcycle(), MILLIS_PER_FRAME));
    sprite.addAnimation(new Animation(_buildDownwardsWalkcycle(), MILLIS_PER_FRAME));
  }

  private PImage[] _buildUpwardsIdle() {
    return Arrays.copyOfRange(_getSheetRow(UPWARDS_WALK_IDX), 1, 2);
  }

  private PImage[] _buildHorizontalIdle() {
    return Arrays.copyOfRange(_getSheetRow(HORIZONTAL_WALK_IDX), 1, 2);
  }

  private PImage[] _buildDownwardsIdle() {
    return Arrays.copyOfRange(_getSheetRow(DOWNWARDS_WALK_IDX), 1, 2);
  }

  private PImage[] _buildUpwardsWalkcycle() {
    return Arrays.copyOfRange(_getSheetRow(UPWARDS_WALK_IDX), 0, WALK_FRAMES_LENGTH);
  }

  private PImage[] _buildHorizontalWalkcycle() {
    return Arrays.copyOfRange(_getSheetRow(HORIZONTAL_WALK_IDX), 0, WALK_FRAMES_LENGTH);
  }

  private PImage[] _buildDownwardsWalkcycle() {
    return Arrays.copyOfRange(_getSheetRow(DOWNWARDS_WALK_IDX), 0, WALK_FRAMES_LENGTH);
  }
  
  private PImage[] _getSheetRow(int animationIdx) {
    return unitSheet.getRowOfTiles(_getSpriteIdx() + animationIdx);
  }

  /**
   * All animations' indexes map to unit sprites in data/units/spritesheet.
   */
  private HashMap<Integer, Integer> _buildTypeToSpriteMap() {
//    int LINES_OF_SPRITES_PER_UNIT = 3;
    HashMap<Integer, Integer> map = new HashMap();

    // Creeps
    map.put(UnitUtils.PEASANT, 9 * 3);
    map.put(UnitUtils.FOOTMAN, 2 * 3);

    // Guards
    map.put(UnitUtils.GRUNT, 23 * 3);

    return map;
  }

  private int _getSpriteIdx() {
    return typeToSpriteMap.get(unit.getType());
  }
}