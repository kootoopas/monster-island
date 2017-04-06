import java.util.*;

import tiled.core.Map;
import tiled.core.MapLayer;
import tiled.core.TileLayer;
import tiled.io.TMXMapReader;

class Stage {
  public static final String STAGES_DIR = "/Users/Fotis/workspace/city/s6/gamesmedia/monster-island/products/code/MonsterIsland/assets/stages";
  
  private Map map;
  private List<PGraphics> layerGraphics;
  
  Stage(String id) {
    try {
      map = new TMXMapReader().readMap(STAGES_DIR + "/" + id + "/" + id + ".tmx");
    } catch (Exception e) {
      println("Error while reading the map:\n" + e.getMessage());
      return;
    }
    
    layerGraphics = new LinkedList();
  }
    
  void setup() {
    for (MapLayer layer : map) {
      if (layer instanceof TileLayer) {
        layerGraphics.add(_createLayerImg((TileLayer) layer));
      }
    }
  }
  
  void draw() {
    for (PGraphics lg : layerGraphics) {
      image(lg, 100, 100);
    }
  }
  
  private PImage _createLayerImg(TileLayer layer) {
    println(layer.getName());
    final int tileWidth = map.getTileWidth();
    final int tileHeight = map.getTileHeight();
    final int tilesPerRow = map.getWidth();
    final int tilesPerCol = map.getHeight();
    
    PImage lg = createGraphics(tilesPerRow * tileWidth, tilesPerCol * tileHeight);
    for (int y = 0; y < tilesPerRow; y++) {
      for (int x = 0; x < tilesPerCol; x++) {
        final Tile tile = layer.getTileAt(x, y);
        if (tile == null) {
          continue;
        }
        
        final Image image = tile.getImage();
        if (image == null) {
          continue;
        }
      }
    }
    return img;
  }
}
