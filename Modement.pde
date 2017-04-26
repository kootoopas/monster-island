interface Movement {
  static final int STILL = 0;
  static final int MOVING = 1;
  static final int INTERRUPTED = 2;

  void setDest(PVector nextDest);
  boolean destReached();
  int getDirection();
  void update();
}