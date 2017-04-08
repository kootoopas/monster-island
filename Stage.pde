import java.util.*;
import java.awt.*;
import java.nio.file.*;
import java.nio.charset.*;
import tiled.core.Map;
import tiled.core.MapLayer;
import tiled.core.TileLayer;
import tiled.io.TMXMapReader;

class Stage {
  public static final String STAGES_DIR = "/Users/Fotis/workspace/city/s6/gamesmedia/monster-island/products/code/MonsterIsland/assets/stages";
  public static final String STAGE_DATAFILE = "data.json";
  
  public static final String PATH = "path";
  public static final String NODES = "nodes";
  
  private String id;
  private CustomWorld world;
  
  private PVector offset;
  
  private Map map;
  private int tileWidth;
  private int tileHeight;
  private int tilesPerRow;
  private int tilesPerCol;
  private LinkedList<TileLayer> tileLayers;
  
  private Group<Node> nodes;
  private LinkedList<PVector> path;
  private int initialGold;
  // private WaveSeq waves

  Stage(String id, CustomWorld world) {
    this.id = id;
    this.world = world;
    
    try {
      this.map = new TMXMapReader().readMap(STAGES_DIR + "/" + id + "/" + id + ".tmx");
    } catch (Exception e) {
      println("Error while reading the map:\n" + e.getMessage());
      return;
    }
    
    this.offset = new PVector(0, 0);
    this.tileWidth = Utils.scale(map.getTileWidth());
    this.tileHeight = Utils.scale(map.getTileHeight());
    this.tilesPerRow = map.getWidth();
    this.tilesPerCol = map.getHeight();
    this.tileLayers = new LinkedList();
    
    this.nodes = new Group(world);
    this.path = new LinkedList();
    
    try {
      JSONObject stageData = parseJSONObject(Utils.readFile(STAGES_DIR + "/" + id + "/" + STAGE_DATAFILE));
      this.initialGold = stageData.getInt("initialGold");
    } catch (IOException e) {
      println("Error while reading the map:\n" + e.getMessage());
      return;
    }
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
            path.add(new PVector((float) _offsetX((int) obj.getX()), (float) _offsetY((int) obj.getY())));
          }
        } else if (layerName.equals(NODES)) {
          // Extract nodes.
          while (objs.hasNext()) {
            obj = objs.next();
            nodes.add(new Node((float) _offsetX((int) obj.getX()), (float) _offsetY((int) obj.getY()), world));
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
//        img.resize(Utils.scale(tileWidth), Utils.scale(tileHeight));
        
        image(img, _offsetX(x * Utils.scale(tileWidth)), _offsetY(y * Utils.scale(tileWidth)));
      }
    }
  }
  
  private float _offsetX(int x) {
    return x + offset.x;
  }
  
  private float _offsetY(int y) {
    return y + offset.y;
  }
  
  public void setOffset(int x, int y) {
    offset = new PVector(x, y);
  }
  
  public LinkedList<PVector> getPath() {
    return path;
  }
  
  public int getInitialGold() {
    return initialGold;
  }
}
