import hermes.*;
import hermes.hshape.*;
import hermes.animation.*;
import hermes.physics.*;
import hermes.postoffice.*;

class MainMenu extends CWorld {
  
  void setup() {
  }
  
  void draw() {
    background(Utils.VERY_DARK_VIOLET);
    fill(#ffffff);
    text("Main Menu", 32, 32);
  }
}


class RatingCalculation extends CWorld {
  
  void draw() {
    background(Utils.VERY_DARK_VIOLET);
    fill(#ffffff);
    textSize(64);
    text("YOU WON", 128, 128);
  }
}


class GameOver extends CWorld {
  
  void draw() {
    background(Utils.VERY_DARK_VIOLET);
    fill(#ffffff);
    textSize(64);
    text("GAME OVER", 128, 128);
  }
}
