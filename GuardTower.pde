class GuardTower extends Tower {

  public static final int CAP = 3;
  public static final int RESPAWN_COOLDOWN = 2000;
  public static final int RALLYPOINT_RANGE = 50;

  protected Group<Guard> guards;
  protected PVector rallypoint;
  protected float lastSpawn = HermesMath.MINUS_INFINITY;

  public GuardTower(int type, Node node, Player player, Game game) {
    super(Tower.MELEE, node, player, game);
    _register();
    this.guards = new Group(game);
    this.rallypoint = _calcInitialRallypoint();
  }

  public Group<Guard> getGuards() {
    return guards;
  }

  public PVector getRallypoint() {
    return rallypoint;
  }

  public PVector getSpawnpoint() {
    return getCenter();
  }

  public void update() {
    if (guards.size() < CAP
            && _cooldownIsOver()) {
      _spawnGuard();
    }
  }

  public void addToGuards(Guard guard) {
    player.addToGuards(guard);
    guards.add(guard);
  }

  private void _spawnGuard() {
    new Guard(UnitUtils.GRUNT, this, game);
    lastSpawn = millis();
  }

  private PVector _calcInitialRallypoint() {
    // store pairs of vertices that are adjacent path elements
    //    whose line contains at least one point
    //      for which dist(point, nodeCenter) < RALLYPOINT_RANGE
    // set initial rallypoint to

    return new PVector(300, 300);
  }

  private boolean _cooldownIsOver() {
    return millis() - lastSpawn > RESPAWN_COOLDOWN;
  }

  protected void _register() {
    super._register();
    game.register(this);
    player.addToTowers(this);
    node.setTower(this);
  }
}