public class IndexListOfTypeStrand {
  
  public int currentSelectedStrand = 0;
  public int currentIndex = 0;
  private DnaStrandTypes[] DnaStrands = new DnaStrandTypes[0];
  
  public void Add(DnaStrandTypes strand) {
    var newSize = DnaStrands.length + 1; //<>//
    DnaStrandTypes[] tempArray = new DnaStrandTypes[newSize];
    
    for(int i = 0; i < DnaStrands.length; i++)
      tempArray[i] = DnaStrands[i];
      
    DnaStrands = new DnaStrandTypes[newSize];
    DnaStrands = tempArray;
    DnaStrands[newSize - 1] = strand;
  }
  
  ///
  // Create a temp variable to store the old values and reset the DnaStrands array to the new values.
  ///
  public void RemoveAtPosition(int index) {
    var minimumIndexSize = DnaStrands.length - 1;
    if (index > minimumIndexSize)
      throw new RuntimeException("Index not found!");
      
      var newSize = DnaStrands.length - 1;
      DnaStrandTypes[] tempArray = new DnaStrandTypes[newSize];
      
      int i = 0;
      for(int t = 0; t < DnaStrands.length; t++) {
          tempArray[i] = DnaStrands[t];
        
        if (t == index - 1) {
          t++;
        }
        
        i++;
      }
      
       DnaStrands = new DnaStrandTypes[newSize];
       DnaStrands = tempArray;
       
       if (index >= currentSelectedStrand) currentSelectedStrand--;
  }
  
  ///
  // Create a temp variable to store the old values and reset the DnaStrands array to the new values.
  ///
  public void AddTypeAtPosition(DnaStrandTypes strand, int index) {
    
    var minimumIndexSize = DnaStrands.length - 1;
    if (index > minimumIndexSize)
      throw new RuntimeException("Index not found!");
    
    var newSize = DnaStrands.length + 1;
    DnaStrandTypes[] tempArray = new DnaStrandTypes[newSize];
    
    int i = 0;
      for(int t = 0; t < DnaStrands.length; t++) {
        if (t == index) {
          tempArray[i] = strand;
          i++;
          tempArray[i] = DnaStrands[t];
        } else {
          tempArray[i] = DnaStrands[t];
        }
        i++;
      }
      
       DnaStrands = new DnaStrandTypes[newSize];
       DnaStrands = tempArray;
       
       if (index <= currentSelectedStrand) currentSelectedStrand++;
  }
  
  public DnaStrandTypes GetCurrent() {
    return DnaStrands[currentSelectedStrand];
  }
  
  public DnaStrandTypes GetNext() {
    currentSelectedStrand++;
    
    if (currentSelectedStrand >= Count()) currentSelectedStrand = 0;
    
    return DnaStrands[currentSelectedStrand];
  }
  
  public DnaStrandTypes[] GetStrandsInArrayFormat() {
    return DnaStrands;
  }
  
  public int Count() {
    return DnaStrands.length;
  }
}
