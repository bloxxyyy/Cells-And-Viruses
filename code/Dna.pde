public class Dna  {  
  public IndexListOfTypeStrand DnaStrand = new IndexListOfTypeStrand();
  
  public Dna() {
    GenerateFirstDnaStrand();
  }
  
  public void GenerateFirstDnaStrand() {
    for (int i = 0; i < 5; i++) {
      int size = DnaStrandTypes.values().length;
      DnaStrandTypes type = DnaStrandTypes.values()[(int)random(0, size)];
      DnaStrand.Add(type);
    }
  }
}
