import java.util.*;

import java.awt.*;
import tiled.core.Map;
import tiled.core.MapLayer;
import tiled.core.TileLayer;
import tiled.io.TMXMapReader;

class Stage {
  public static final String STAGES_DIR = "/Users/Fotis/workspace/city/s6/gamesmedia/monster-island/products/code/MonsterIsland/assets/stages";
  
  private Map map;
  private int tileWidth;
  private int tileHeight;
  private int tilesPerRow;
  private int tilesPerCol;
  private LinkedList<TileLayer> tileLayers;

  Stage(String id) {
    try {
      map = new TMXMapReader().readMap(STAGES_DIR + "/" + id + "/" + id + ".tmx");
    } catch (Exception e) {
      println("Error while reading the map:\n" + e.getMessage());
      return;
    }
    
    tileWidth = map.getTileWidth();
    tileHeight = map.getTileHeight();
    tilesPerRow = map.getWidth();
    tilesPerCol = map.getHeight();
    tileLayers = new LinkedList();
  }
    
  void setup() {
    for (MapLayer layer : map) {
      if (layer instanceof TileLayer) {
        tileLayers.add((TileLayer) layer);
      }
    }
  }
  
  void draw() {
    for (TileLayer layer : tileLayers) {
      _drawLayerTiles(layer);
    }
  }
  
  private void _drawLayerTiles(TileLayer layer) {
    for (int y = 0; y < tilesPerCol; y++) {
      for (int x = 0; x < tilesPerRow; x++) {
        final Tile tile = layer.getTileAt(x, y);
        if (tile == null) {
          continue;
        }
        
        final Image img = tile.getImage();
        if (img == null) {
          continue;
        }
        
        image(new PImage(img), x * tileWidth, y * tileWidth);
      }
    }
  }
}
