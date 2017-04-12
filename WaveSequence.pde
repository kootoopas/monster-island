class WaveSequence {  
  private LinkedList<Wave> waves;

  WaveSequence(JSONArray wavedataArray, Path path, Game game) {
    this.waves = new LinkedList();
    for (int i = 0; i < wavedataArray.size(); i++) {
      this.waves.add(new Wave(wavedataArray.getJSONObject(i), path, game));
    }
  }
  
  public boolean isDone() {
    // Since the last wave is done, the whole sequence is.
    return this.waves.getLast()
      .isDone();
  }
}

class Wave extends Group<Creep> {
  
  private Game game;

  private int spawnsAt;

  private static final int NOT_YET = 0;
  private static final int YES = 1;
  private static final int DONE = 2;
  private int spawning = NOT_YET;
  
  private Path path;
  
  private JSONObject creepdata;
  private String[] creepTypes;

  private int currTypeI = -1;
  private int currTypeRemainingCreeps = 0;
  private int CREEP_SPAWN_TIMESTEP = 300;
  private int lastCreepSpawn = CREEP_SPAWN_TIMESTEP;

  
  Wave(JSONObject wavedata, Path path, Game game) {
    super(game);
    this.game = game;
    this.path = path;
    
    this.spawnsAt = wavedata.getInt("spawnsAt");

    this.creepdata = wavedata.getJSONObject("creeps");
    
    // XXX: Isolate iteration to different object.
    this.creepTypes = _extractCreepTypes();

    game.register(this);
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
    // XXX: Isolate iteration to different object.
    
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
    
    Creep nextCreep = new Creep(UnitUtils.stringToType(creepTypes[currTypeI]), path, (CWorld) game);
    add(nextCreep);
    
    // Monitor when this creep spawned.
    lastCreepSpawn = millis();
    
    currTypeRemainingCreeps--;
  }
  
  private PVector _randomNearbyOffset(PVector point) {
    return point;
  }
  
  private boolean _spawntimeIsNow() {
    return Utils.millisToSecs(millis()) == spawnsAt;
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
