class AssetManager {

  private HashMap<String, Object> assets = new HashMap();

  public void put(String key, PImage img) {
    put(key, (Object) img);
  }

  public void put(String key, Tileset tileset) {
    put(key, (Object) tileset);
  }

  public void put(String key, Object asset) {
    assets.put(key, asset);
  }

  public PImage getImage(String key) {
    if (assets.containsKey(key)
            && assets.get(key) instanceof PImage) {
      return (PImage) assets.get(key);
    } else {
      return null;
    }
  }

  public Tileset getSpritesheet(String key) {
    return getTileset(key);
  }

  public Tileset getTileset(String key) {
    if (assets.containsKey(key)
            && assets.get(key) instanceof Tileset) {
      return (Tileset) assets.get(key);
    } else {
      return null;
    }
  }

  public String toString() {
    return "AssetManager{" +
            "assets=" + assets +
            '}';
  }
}
