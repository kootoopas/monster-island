import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

abstract class CustomWorld extends World {
  
  abstract void handleEvent(Being being);
  
  void switchTo(CustomWorld nextWorld) {
    this.deactivate();
    nextWorld.start();
  }
}
