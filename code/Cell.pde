public class Cell implements ICell, IPosition {
  private PVector _Position;
  private String _Name;
  private Dna _Dna = new Dna();
  
  public void DoAction(Clock clock, ArrayList<Cell> cells) {
     var type = _Dna.GetActionOfDnaStrand(clock);
     var speed = 3;
     
     if (type != DnaStrandTypes.STASIS) {
       var r = floor(random(0, 4));
       if (r == 0 && _Position.x + speed < width) _Position = new PVector(_Position.x + speed, _Position.y);
       if (r == 1 && _Position.x - speed > 0) _Position = new PVector(_Position.x - speed, _Position.y);
       if (r == 2 && _Position.y + speed < height) _Position = new PVector(_Position.x, _Position.y + speed);
       if (r == 3 && _Position.y - speed > 0) _Position = new PVector(_Position.x, _Position.y - speed);
     }
     
     if (type == DnaStrandTypes.FIND  && IsVirus()) {
       Cell cell = GetNearestNormalCell(cells);
       var tempPos = new PVector(cell.getPosition().x, cell.getPosition().y);
       var direction = tempPos.sub(getPosition()).normalize();
       var directionSpeed = new PVector(direction.x * speed, direction.y * speed);
       _Position = getPosition().add(directionSpeed);
     }
     
     
  }
  
  private Cell GetNearestNormalCell(ArrayList<Cell> cells) {
    
    Cell cloasestCell = null;
    float closestDistance = -1;
    
    for (int i = 0; i < cells.size(); i++) {
      if (!cells.get(i).IsVirus()) {

          float thisDistance = _Position.dist(cells.get(i).getPosition());
      
          if (thisDistance < closestDistance || closestDistance == -1)
          {
             closestDistance = thisDistance;
             cloasestCell = cells.get(i);
          }
        
      }
    }
    
    return cloasestCell;
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
