class CWorldManager {
  private CWorld world;

  public void start() {
    world.start();
  }

  public void draw() {
    world.draw();
  }

  public void setInitialWorld(CWorld initialWorld) {
    _setWorld(initialWorld);
  }

  public void transitionTo(CWorld nextWorld) {
    world.deactivate();
    _setWorld(nextWorld);
    start();
  }

  private void _setWorld(CWorld nextWorld) {
    world = nextWorld;
    world.setManager(this);
  }
}
