  class WaveSequence {
  private Game game;
  
  private LinkedList<Wave> waves;
  private Path path;
  
  // TODO: Need to spawn initial wave's units first, then others at spawnsAt.

  WaveSequence(JSONArray wavedataArray, Path path, Game game) {
    this.waves = new LinkedList();
    for (int i = 0; i < wavedataArray.size(); i++) {
      this.waves.add(new Wave(wavedataArray.getJSONObject(i), path, game));
    }
  }
}

class Wave {

  private Game game;

  private LinkedList<Unit> creeps;
  private int spawnsAt;
  
  private Path path;
  
  Wave(JSONObject wavedata, Path path, Game game) {
    this.game = game;
    this.path = path;
    this.creeps = new LinkedList();
        
    // Parse "creeps" json object.
    JSONObject creepdata = wavedata.getJSONObject("creeps");
    Iterator creepdataKeys = creepdata.keys()
      .iterator();
    while(creepdataKeys.hasNext()){
      String id = (String) creepdataKeys.next();
      int amount = creepdata.getInt(id);
      
      for (int i = 0; i < amount; i++) {
        // TODO: Delay spawning by a few ms to add space
        this.creeps.add(
          new Creep(UnitUtils.stringToId(id), path.getSpawnpoint(), (CWorld) game)
        );
      }
    }
    
    
    
    this.spawnsAt = wavedata.getInt("spawnsAt");
  }
}
