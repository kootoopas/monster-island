class CreepMovement extends UnitMovement {

  // Dest is initially set to 2nd point of path. (since every creep moves from there first)
  private Iterator pathIter;
  private Creep creep;

  public CreepMovement(Creep creep, Path path) {
    super(creep);
    this.creep = creep;
    this.pathIter = path.iterator();

    // Skip spawnpoint.
    this.pathIter.next();

    this.moveTo((PVector) pathIter.next());
  }

  public void update() {
    if (destReached()) {
      if (pathIter.hasNext()) {
        moveTo((PVector) pathIter.next());
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
