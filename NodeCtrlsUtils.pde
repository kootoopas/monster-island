static class NodeCtrlsUtils {

  private static HRectangle _calcRectangle(Node node) {
    float x = node.getX() - Node.SIZE / 2 + Node.SIZE / 2;
    float y = node.getY() - Node.SIZE - Node.SIZE / 3;
    float width = Node.SIZE;
    float height = Node.SIZE;

    return new HRectangle(x, y, width, height);
  }
}