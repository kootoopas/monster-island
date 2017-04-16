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

  private int playerHp;
  private int stars;
  private String starsText;

  public RatingCalculation(int playerHp) {
    this.playerHp = playerHp;
    _calc();
  }

  private void _calc() {
    if (playerHp >= 20) {
      stars = 3;
      starsText = "★★★";
    } else if (playerHp >= 12) {
      stars = 2;
      starsText = "★★";
    } else {
      stars = 1;
      starsText = "★";
    }
  }

  private void _drawStars() {
    fill(#fff700);
    textSize(64);
    text(starsText, 200, 256);
  }

  void draw() {
    background(Utils.VERY_DARK_VIOLET);
    fill(#ffffff);
    textSize(48);
    text("YOU WON", 128, 128);
    _drawStars();
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
