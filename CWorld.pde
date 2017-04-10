import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

abstract class CWorld extends World implements EventHandler {
    
  void switchTo(CWorld nextWorld) {
    this.deactivate();
    nextWorld.start();
  }
  
  void handleEvent(Being being) {}
}

interface EventHandler {
  void handleEvent(Being being);
}
