class WaveSequence {
  
  LinkedList<Wave> waves;
  
  WaveSequence(JSONArray wavedataArray) {
    
    this.waves = new LinkedList();
    for (int i = 0; i < wavedataArray.size(); i++) {
      this.waves.add(new Wave(wavedataArray.getJSONObject(i)));
    }
  }
}

class Wave {

  Wave(JSONObject wavedata) {
    println(wavedata);
//    this.units = wavedata.get;
  }
}
