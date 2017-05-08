abstract class CBeing extends Being {
  // TODO: Add Group[] param to add being to groups in constructor.
  public CBeing(HShape collisionShape) {
    super(collisionShape);
  }

  public PVector getCenter() {
    return getBoundingBox().getCenter();
  }
}
