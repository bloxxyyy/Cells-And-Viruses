public class Dna {  
  
  public IndexListOfTypeStrand DnaStrand = new IndexListOfTypeStrand();
  private int _DnaStrandSize = 4;
  
  public Dna() {
    GenerateFirstDnaStrand();
  }
  
  long OldMinute = 0;
  public DnaStrandTypes GetActionOfDnaStrand(Clock clock) {
    var currentMinute = clock.GetClockTimeMinutes();
    if (OldMinute != currentMinute) {
      OldMinute = currentMinute;
      return DnaStrand.GetNext();
    }
    
    return DnaStrand.GetCurrent();
  }
  
  public void GenerateFirstDnaStrand() {
    for (int i = 0; i < _DnaStrandSize; i++) {
      int size = DnaStrandTypes.values().length;
      DnaStrandTypes type = DnaStrandTypes.values()[(int)random(0, size)];
      DnaStrand.Add(type);
    }
  }
}
