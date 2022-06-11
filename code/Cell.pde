public class Cell implements ICell, IPosition {
  private PVector _Position;
  private String _Name;
  private Dna _Dna = new Dna();
  
  public void DoAction(Clock clock) {
     var type = _Dna.GetActionOfDnaStrand(clock);
     var speed = 3;
     
     if (type != DnaStrandTypes.STASIS) {
       var r = floor(random(0, 4));
       if (r == 0 && _Position.x + speed < width) _Position = new PVector(_Position.x + speed, _Position.y);
       if (r == 1 && _Position.x - speed > 0) _Position = new PVector(_Position.x - speed, _Position.y);
       if (r == 2 && _Position.y + speed < height) _Position = new PVector(_Position.x, _Position.y + speed);
       if (r == 3 && _Position.y - speed > 0) _Position = new PVector(_Position.x, _Position.y - speed);
     }
     
     
  }
  
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
