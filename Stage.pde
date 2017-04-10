import java.util.*;
import java.awt.*;
import java.nio.file.*;
import tiled.core.Map;
import tiled.core.MapLayer;
import tiled.core.TileLayer;
import tiled.io.TMXMapReader;

class Stage {
  public static final String STAGES_DIR = "stages";
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
  private Path path;
  private int initialGold;
  private JSONArray wavedataArray;

  Stage(String id, CustomWorld world) {
    this.id = id;
    this.world = world;
    
    try {
      this.map = new TMXMapReader().readMap(dataPath(STAGES_DIR + "/" + id + "/" + id + ".tmx"));
    } catch (Exception e) {
      println("Error while reading the map:\n" + e.getMessage());
      return;
    }
    
    this.tileWidth = Utils.scale(map.getTileWidth());
    this.tileHeight = Utils.scale(map.getTileHeight());
    this.tilesPerRow = map.getWidth();
    this.tilesPerCol = map.getHeight();
    this.tileLayers = new LinkedList();
    
    this.nodes = new Group(world);
    this.path = new Path();
    
    try {
      JSONObject stagedata = parseJSONObject(
        Utils.readFile(
          dataPath(STAGES_DIR + "/" + id + "/" + STAGE_DATAFILE)
        )
      );
      this.initialGold = stagedata.getInt("initialGold");
      this.wavedataArray = stagedata.getJSONArray("waves");
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
          // XXX: Path is represented poorly by tiled rectangle points. Should be a polyline, but libtiled doesn't
          //      support polyline parsing right now (04/2017). Maybe copy-pasta polyline parsing code from libgdx?
          while (objs.hasNext()) {
            obj = objs.next();
            path.add(new PVector((float) _offsetX((int) obj.getX()), (float) _offsetY((int) obj.getY())));
          }
        } else if (layerName.equals(NODES)) {
          // Extract nodes.
          while (objs.hasNext()) {
            obj = objs.next();
            nodes.add(new Node((float) _offsetX((int) obj.getX()), (float) _offsetY((int) obj.getY()), (Game) world));
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
  
  public void setOffset(int x, int y) {
    offset = new PVector(x, y);
  }
  
  private float _offsetX(int x) {
    return x + offset.x;
  }
  
  private float _offsetY(int y) {
    return y + offset.y;
  }
  
  public Path getPath() {
    return path;
  }
  
  public int getInitialGold() {
    return initialGold;
  }
  
  public JSONArray getWavedataArray() {
    return wavedataArray;
  }
}


class Path extends LinkedList<PVector> {  
  Path() {
    super();
  }
  
  public PVector getSpawnpoint() {
    return getFirst();
  }
  
  public PVector getGuardpoint() {
    return getLast();
  }
}


// TODO: Move map related code to these on a late refactor.
class MapParser {}
class MapRenderer {}
