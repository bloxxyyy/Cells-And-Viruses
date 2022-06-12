public class Dna {  
  
  public IndexListOfTypeStrand DnaStrand = new IndexListOfTypeStrand();
  private int _DnaStrandSize = 6;
  
  public Dna(boolean canBeVirus) {
    GenerateFirstDnaStrand(canBeVirus);
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
  
  public void GenerateFirstDnaStrand(boolean canBeVirus) {
    int size = DnaStrandTypes.values().length;
    DnaStrandTypes type = DnaStrandTypes.STASIS;

    for (int i = 0; i < _DnaStrandSize; i++) {
      boolean allowedType = false;
      
      while (!allowedType) {
        type = DnaStrandTypes.values()[(int)random(0, size)];
        
        if (type == DnaStrandTypes.INFECTED || type == DnaStrandTypes.ERREDICATE) {
          var hasTypeNotAllowed = false;
          
          for (int s = 0; s < DnaStrand.Count(); s++) {
            if (DnaStrand.GetStrandsInArrayFormat()[s] == DnaStrandTypes.ERREDICATE) hasTypeNotAllowed = true;
            if (DnaStrand.GetStrandsInArrayFormat()[s] == DnaStrandTypes.INFECTED) hasTypeNotAllowed = true;
          }
          
          if(!canBeVirus) hasTypeNotAllowed = true;
          
          if (!hasTypeNotAllowed) allowedType = true;
        } else {
          allowedType = true;
        }
        
      }
      
      DnaStrand.Add(type);
    }
  }
}
