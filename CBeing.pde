abstract class CBeing extends Being {

  protected AnimatedSprite sprite;

  public CBeing(HShape collisionShape) {
    super(collisionShape);

    sprite = new AnimatedSprite();
  }
}