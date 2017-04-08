import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

abstract class CustomWorld extends World implements EventHandler {
    
  void switchTo(CustomWorld nextWorld) {
    this.deactivate();
    nextWorld.start();
  }
  
  void handleEvent(Being being) {}
}

interface EventHandler {
  void handleEvent(Being being);
}
