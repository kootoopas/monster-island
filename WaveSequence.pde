class WaveSequence {  
  private LinkedList<Wave> waves = new LinkedList();
  private Group<Creep> creeps;
  private Path path;

  private boolean started = false;
  private JSONArray wavedataArray;
  private Game game;

  WaveSequence(JSONArray wavedataArray, Path path, Game game) {
    this.path = path;
    this.creeps = new Group(game);
    this.wavedataArray = wavedataArray;
    this.game = game;
  }

  public void start() {
    for (int i = 0; i < wavedataArray.size(); i++) {
      this.waves.add(new Wave(wavedataArray.getJSONObject(i), this, game));
    }
    started = true;
  }

  public boolean haveAllWavesSpawned() {
    // Since the last wave finished spawning, the whole sequence has.
    return waves.getLast()
      .hasSpawned();
  }
  
  public boolean areAllCreepsDead() {
    if (!haveAllWavesSpawned()) return false;
    
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

  public boolean hasNotStarted() {
    return !started;
  }
}
