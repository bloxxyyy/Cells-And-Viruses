public class Cell implements ICell, IPosition {
  private PVector _Position;
  private String _Name;
  private Dna _Dna = new Dna();
  
  public void SetName(String name) {
    _Name = name;
  }
  
  public String GetName() {
    return _Name;
  }
  
  public PVector getPosition() {
    return _Position;
  }
  
  public void SetPosition(PVector position) {
    _Position = position;
  }
  
  public Dna GetDna() {
    return _Dna;
  }
  
  public boolean IsVirus() {
    for (int s = 0; s < GetDna().DnaStrand.Count(); s++) {
      if (GetDna().DnaStrand.GetStrandsInArrayFormat()[s] == DnaStrandTypes.INFECTED) return true;
    }
    
    return false;
  }
}
