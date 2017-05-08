class CAnimatedSprite extends AnimatedSprite {

  private int activeAnimationIndex;

  public void setActiveAnimation(int animationIndex) {
    super.setActiveAnimation(animationIndex);
    activeAnimationIndex = animationIndex;
  }

  public int getActiveAnimationIndex() {
    return activeAnimationIndex;
  }
}