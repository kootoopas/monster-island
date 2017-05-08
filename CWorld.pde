abstract class CWorld extends World {
  private CWorldManager manager;

  /**
   * Should only be used internally by CWorldManager.
   */
  public void setManager(CWorldManager manager) {
    this.manager = manager;
  }
  
  public void transitionTo(CWorld nextWorld) {
    manager.transitionTo(nextWorld);
  }

}
