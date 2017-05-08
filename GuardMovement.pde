class GuardMovement extends UnitMovement {

  public GuardMovement(Guard guard, PVector rallypoint) {
    super(guard);
    moveTo(rallypoint);
  }
}