class UnitMovement implements Movement {

  public static final int UP = 0;
  public static final int RIGHT = 1;
  public static final int DOWN = 2;
  public static final int LEFT = 3;

  private Unit unit;
  protected int status = Movement.STILL;
  protected float spd;
  protected PVector dest;
  protected int direction = DOWN;
  private boolean destReached = false;

  public UnitMovement(Unit unit) {
    this.unit = unit;
    this.spd = unit.getStats().spd;
    this.dest = unit.getPosition();
  }

  public UnitMovement(Creep creep) {
    this((Unit) creep);
  }

  public UnitMovement(Guard guard) {
    this((Unit) guard);
  }

  public void update() {
    if (destReached()) return;

    float finalSpd;
    if (unit.isFrostbitten()) {
      finalSpd = spd * UnitHealth.FROSTBITE_SPD;
    } else {
      finalSpd = spd;
    }

    float dx = dest.x - unit.getX();
    float dy = dest.y - unit.getY();
    float dist = sqrt(dx * dx + dy * dy);

    if (dist > finalSpd) {
      float ratio = finalSpd / dist;
      float xMove = ratio * dx;
      float yMove = ratio * dy;
      unit.setX(xMove + unit.getX());
      unit.setY(yMove + unit.getY());
    } else {
      unit.setPosition(dest);
      unit.getAnimator()
              .setIdle();
      destReached = true;
    }

    // IDEA: Berserk shaky movement mode (works for non distance checking movement though :/)
    //       if unit.getX() > dest.x is removed the unit moves in a shaky freaky way.
  }

  public void moveTo(PVector nextDest) {
    if (!dest.equals(nextDest)) {
      destReached = false;
      dest = nextDest;
      _setDirection();
    }
  }

  private void _setDirection() {
    int nextDirection;
    int nextAnimation;
    float dy = dest.y - unit.getY();
    float dx = dest.x - unit.getX();
    float angle = degrees(
            atan2(dy, dx));

    if (angle <= 45 && angle >= -45) {
      nextDirection = RIGHT;
      nextAnimation = UnitAnimator.HORIZONTAL_WALK_IDX;
    } else if (angle < -45 && angle > -135) {
      nextDirection = UP;
      nextAnimation = UnitAnimator.UPWARDS_WALK_IDX;
    } else if (angle < -135 || angle > 135) {
      nextDirection = LEFT;
      nextAnimation = UnitAnimator.HORIZONTAL_WALK_IDX;
    } else {
      // Between 135 & 45 is implied.
      nextDirection = DOWN;
      nextAnimation = UnitAnimator.DOWNWARDS_WALK_IDX;
    }

    if (directionChanged(nextDirection)) {
      unit.getAnimator()
              .setActiveAnimation(nextAnimation);
      direction = nextDirection;
    }
  }

  public int getDirection() {
    return direction;
  }

  public boolean directionChanged(int newDirection) {
    return direction != newDirection;
  }

  public boolean destReached() {
    return destReached;
  }

  public void setSpd(float spd) {
    this.spd = spd;
  }
}
