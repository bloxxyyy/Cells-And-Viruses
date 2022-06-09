public class Dna  {  
  public IndexListOfTypeStrand DnaStrand = new IndexListOfTypeStrand();
  private int _DnaStrandSize = 2; // good starter, based on enviroment we might add more.
  
  public Dna() {
    GenerateFirstDnaStrand();
  }
  
  public void GenerateFirstDnaStrand() {
    for (int i = 0; i < _DnaStrandSize; i++) {
      int size = DnaStrandTypes.values().length;
      DnaStrandTypes type = DnaStrandTypes.values()[(int)random(0, size)];
      DnaStrand.Add(type);
    }
  }
}
