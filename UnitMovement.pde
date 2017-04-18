class UnitMovement implements Movement {

  private Unit unit;
  protected int status = Movement.STILL;
  protected float spd;
  protected PVector dest;
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
    }
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