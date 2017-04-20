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

  public void update() {
    if (destReached()) return;

    float dx = dest.x - unit.getX();
    float dy = dest.y - unit.getY();
    float dist = sqrt(dx * dx + dy * dy);

    if (dist > spd) {
      float ratio = spd / dist;
      float xMove = ratio * dx;
      float yMove = ratio * dy;
      unit.setX(xMove + unit.getX());
      unit.setY(yMove + unit.getY());
    } else {
      unit.setPosition(dest);
      destReached = true;
    }

    // IDEA: Berserk shaky movement mode (works for non distance checking movement though :/)
    //       if unit.getX() > dest.x is removed the unit moves in a shaky freaky way.
  }

  public void setDest(PVector nextDest) {
    if (!dest.equals(nextDest)) {
      destReached = false;
      dest = nextDest;
      _setDirection();
    }
  }

  private void _setDirection() {
    float angle = degrees(
            PVector.angleBetween(unit.getPosition(), dest)
    );
    // TODO: Figure out how degrees and angleBetween works. (currently it gives values between ~0 and ~15)
//    print(angle);

    if (angle <= 45 || angle >= 315) {
      direction = RIGHT;
    } else if (angle > 45 && angle < 135) {
      direction = UP;
    } else if (angle >= 135 && angle <= 225) {
      direction = LEFT;
    } else {
      // Between 225 & 315 is implied.
      direction = DOWN;
    }
  }

  public int getDirection() {
    return direction;
  }

  public boolean destReached() {
    return destReached;
  }
}


class CreepMovement extends UnitMovement {

  // Dest is initially set to 2nd point of path. (since every creep moves from there first)
  private Iterator pathIter;
  private Creep creep;

  public CreepMovement(Creep creep, Path path) {
    super((Unit) creep);
    this.creep = creep;
    this.pathIter = path.iterator();

    // Skip spawnpoint.
    this.pathIter.next();

    this.setDest((PVector) pathIter.next());
  }

  public void update() {
    if (destReached()) {
      if (pathIter.hasNext()) {
        setDest((PVector) pathIter.next());
      } else {
        _handleGuardpointReach();
      }
    }

    super.update();
  }

  private void _handleGuardpointReach() {
    creep.dmgPlayer();
    creep.unregister();
  }
}


interface Movement {
  static final int STILL = 0;
  static final int MOVING = 1;
  static final int INTERRUPTED = 2;

  void setDest(PVector nextDest);
  boolean destReached();
  void update();
}