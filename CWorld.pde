import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

abstract class CWorld extends World implements EventHandler {
  
  private CWorldManager manager;
  
  public void setManager(CWorldManager manager) {
    this.manager = manager;
  }
  
  public void transitionTo(CWorld nextWorld) {
    manager.transitionTo(nextWorld);
  }
  
  void handleEvent(Being being) {}
}


interface EventHandler {
  void handleEvent(Being being);
}


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
