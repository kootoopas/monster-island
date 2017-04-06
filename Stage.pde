import java.util.*;

import tiled.core.Map;
import tiled.core.MapLayer;
import tiled.core.TileLayer;
import tiled.io.TMXMapReader;
import tiled.core.view.MapRenderer;
import tiled.core.view.OrthogonalRenderer;

class Stage {
  public static final String STAGES_DIR = "/Users/Fotis/workspace/city/s6/gamesmedia/monster-island/products/code/MonsterIsland/assets/stages";
  
  private Map map;
  private List<PImage> layerImgs;
  
  Stage(String id) {
    try {
      map = new TMXMapReader().readMap(STAGES_DIR + "/" + id + "/" + id + ".tmx");
    } catch (Exception e) {
      println("Error while reading the map:\n" + e.getMessage());
      return;
    }
    
    layerImgs = new LinkedList();
  }
    
  void setup() {
    for (MapLayer layer : map) {
      if (layer instanceof TileLayer) {
        layerImgs.add(_createLayerImg((TileLayer) layer));
      }
    }
  }
  
  void draw() {
    for (PImage img : layerImgs) {
      image(img, 100, 100);
    }
  }
  
  private PImage _createLayerImg(TileLayer layer) {
    final int tileWidth = map.getTileWidth();
    final int tileHeight = map.getTileHeight();
    
    PImage img = createImage(map.getWidth() * tileWidth, map.getHeight() * tileHeight, RGB);
    img.loadPixels();
    for (int i = 0; i < img.pixels.length; i++) {
      img.pixels[i] = color(0, 90, 102); 
    }
    img.updatePixels();
    return img;
  }
}
