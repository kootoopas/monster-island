import java.util.*;
import java.awt.*;
import tiled.core.Map;
import tiled.core.MapLayer;
import tiled.core.TileLayer;
import tiled.io.TMXMapReader;

class Stage {
  public static final String STAGES_DIR = "/Users/Fotis/workspace/city/s6/gamesmedia/monster-island/products/code/MonsterIsland/assets/stages";
  
  public static final String PATH = "path";
  public static final String NODES = "nodes";
  
  private Map map;
  private int tileWidth;
  private int tileHeight;
  private int tilesPerRow;
  private int tilesPerCol;
  private LinkedList<TileLayer> tileLayers;
  
  private Group<Node> nodes;
  private LinkedList<PVector> path;

  Stage(String id, CustomWorld world) {
    try {
      map = new TMXMapReader().readMap(STAGES_DIR + "/" + id + "/" + id + ".tmx");
    } catch (Exception e) {
      println("Error while reading the map:\n" + e.getMessage());
      return;
    }
    
    tileWidth = Calc.scale(map.getTileWidth());
    tileHeight = Calc.scale(map.getTileHeight());
    tilesPerRow = map.getWidth();
    tilesPerCol = map.getHeight();
    tileLayers = new LinkedList();
    
    nodes = new Group(world);
    path = new LinkedList();
  }
    
  void setup() {
    for (MapLayer layer : map) {
      if (layer instanceof TileLayer) {
        // Extract tile layers.
        tileLayers.add((TileLayer) layer);
      } else if (layer instanceof ObjectGroup) {
        String layerName = layer.getName();
        Iterator<MapObject> objs = ((ObjectGroup) layer).getObjects();
        MapObject obj;
        
        if (layerName.equals(PATH)) {
          // Extract path.
          while (objs.hasNext()) {
            obj = objs.next();
            path.add(new PVector((float) obj.getX(), (float) obj.getY()));
          }
        } else if (layerName.equals(NODES)) {
          // Extract nodes.
          while (objs.hasNext()) {
            obj = objs.next();
            nodes.add(new Node((float) obj.getX(), (float) obj.getY(), world));
          }
        }
      }
    }
  }
  
  void drawMap() {
    for (TileLayer layer : tileLayers) {
      _drawTileLayer(layer);
    }
  }
  
  private void _drawTileLayer(TileLayer layer) {
    for (int y = 0; y < tilesPerCol; y++) {
      for (int x = 0; x < tilesPerRow; x++) {
        final Tile tile = layer.getTileAt(x, y);
        if (tile == null) continue;
        
        final Image rawImg = tile.getImage();
        if (rawImg == null) continue;
        
        PImage img = new PImage(rawImg);
// TODO: Enable if pixelart resize is added      
//        img.resize(Calc.scale(tileWidth), Calc.scale(tileHeight));
        
        image(img, x * Calc.scale(tileWidth), y * Calc.scale(tileWidth));
      }
    }
    
  }
  
  public LinkedList<PVector> getPath() {
    return path;
  }
}

static class Calc {
  public static final double SCALE = 1;

  public static int scale(int n) {
    return (int) Math.floor(n * Calc.SCALE);
  };
}
