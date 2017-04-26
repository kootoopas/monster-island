abstract class CWorld extends World {
  
  private CWorldManager manager;
  public CWorldDefaults defaults = new CWorldDefaults();
  
  /**
   * Should be only used internally by CWorldManager.
   */
  public void setManager(CWorldManager manager) {
    this.manager = manager;
  }
  
  public void transitionTo(CWorld nextWorld) {
    manager.transitionTo(nextWorld);
  }

  public CWorldDefaults getDefaults() {
    return defaults;
  }
}
