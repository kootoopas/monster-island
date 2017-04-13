class WaveSequence {  
  private LinkedList<Wave> waves = new LinkedList();
  private Group<Creep> creeps;
  private Path path;

  WaveSequence(JSONArray wavedataArray, Path path, Game game) {
    this.path = path;
    this.creeps = new Group(game);
    
    for (int i = 0; i < wavedataArray.size(); i++) {
      this.waves.add(new Wave(wavedataArray.getJSONObject(i), this, game));
    }
  }
  
  public boolean isDone() {
    // Since the last wave finished spawning, the whole sequence is.
    return waves.getLast()
      .isDone();
  }
  
  public boolean areAllCreepsDead() {
    if (!isDone()) return false;
    
    ListIterator<Wave> iter = waves.listIterator();
    while (iter.hasNext()) {
      if (iter.next().size() > 0) return false;
    }
    
    return true;
  }
  
  public Path getPath() {
    return path;
  }
  
  public Group<Creep> getCreeps() {
    return creeps;
  }
  
  public void addToCreeps(Creep creep) {
    creeps.add(creep);
  }
}

class Wave extends Group<Creep> {
  
  private Game game;
  private WaveSequence seq;

  /**
   * Spawntime in millis.
   */
  private int spawntime;

  private static final int NOT_YET = 0;
  private static final int YES = 1;
  private static final int DONE = 2;
  private int spawning = NOT_YET;
  
  private JSONObject creepdata;
  private String[] creepTypes;

  private int currTypeI = -1;
  private int currTypeRemainingCreeps = 0;
  private int CREEP_SPAWN_TIMESTEP = 300;
  private int lastCreepSpawn = CREEP_SPAWN_TIMESTEP;

  
  Wave(JSONObject wavedata, WaveSequence seq, Game game) {
    super(game);
    this.game = game;
    this.seq = seq;
    
    // XXX: Assumes that it starts when WaveSequence is constructed (=> "Start Waves" button is clicked).
    this.spawntime = millis() + Utils.secsToMillis(wavedata.getInt("spawntime"));

    this.creepdata = wavedata.getJSONObject("creeps");
    
    // XXX: Isolate iteration to different object.
    this.creepTypes = _extractCreepTypes();

    this.game.register(this);
  }
  
  public boolean isDone() {
    return spawning == DONE;
  }
  
  public void update() {
    if (spawning == NOT_YET
        && _spawntimeIsNow()) {
      spawning = YES;
    }

    if (spawning == YES) {
      try {
        _assertNextCreepSpawn();
        _spawnNextCreep();
      } catch(NotYetException e) {
        return;
      }
    }
  }
  
  private void _spawnNextCreep() {
    // XXX: Isolate iteration to different object?
    
    // Done spawning current type of creep.
    if (currTypeRemainingCreeps == 0) {
      // Next type exists.
      if (++currTypeI < creepTypes.length) {
        currTypeRemainingCreeps = creepdata.getInt(creepTypes[currTypeI]);
      } else {
        spawning = DONE;
        return;
      }
    }
    
    Creep nextCreep = new Creep(UnitUtils.stringToType(creepTypes[currTypeI]), seq.getPath(), game);
    add(nextCreep);
    seq.addToCreeps(nextCreep);

    
    // Monitor when this creep spawned.
    lastCreepSpawn = millis();
    
    currTypeRemainingCreeps--;
  }
  
  private boolean _spawntimeIsNow() {
    return spawntime <= millis();
  }
  
  private void _assertNextCreepSpawn() throws NotYetException {
    if (millis() - lastCreepSpawn < CREEP_SPAWN_TIMESTEP) {
      throw new NotYetException();
    }
  }
  
  private String[] _extractCreepTypes() {
    Object[] creepTypeObjs = creepdata.keys()
      .toArray();
    // Convert to array of strings.
    return Arrays.copyOf(creepTypeObjs, creepTypeObjs.length, String[].class);
  }

  private class NotYetException extends Exception {}
}
