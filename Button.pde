import hermes.Being;
import hermes.Hermes;
import hermes.hshape.HRectangle;
import hermes.postoffice.MouseMessage;
import hermes.postoffice.POCodes;

class Button extends Being {
    public static final int WIDTH = 300;
    public static final int HEIGHT = 50;
    private static final String COLOR = "ffffffff";
    private static final String ACTIVE_COLOR = "fffff700";

    private String text;
    private CustomWorld world;

    public Button(int x, int y, String text, CustomWorld world) {
        super(new HRectangle(x, y, WIDTH, HEIGHT));
        this.text = text;
        this.world = world;
    }

    public void receive(MouseMessage msg) {
        if (msg.getAction() == POCodes.Click.PRESSED) {
            world.handleEvent(this);
        }
    }

    public void setText(String text) {
        this.text = text;
    }

    public void draw() {
        fill(33);
        noStroke();
        _shape.draw();

        textSize(16);
        fill(_shape.contains(mouseX, mouseY)
                ? PApplet.unhex(ACTIVE_COLOR)
                : PApplet.unhex(COLOR));
        text(text, 50, 20); //text is drawn in relation to the shapes origin.

    }
}
