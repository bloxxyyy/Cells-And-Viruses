public class Cell implements ICell, IPosition {
  private PVector _Position;
  private String _Name;
  private Dna _Dna;
  private int _Size = 16;
  
  private Cell _IntegratedCell = null;
  private int _FoodTick = 0;
  private int _DieWhenNotFedTickCount = 10;
  
  public Cell(boolean canBeStartupVirus) {
    _Dna = new Dna(canBeStartupVirus);
  }
  
  private DnaStrandTypes oldType = DnaStrandTypes.STASIS;
  private DnaStrandTypes currentType = DnaStrandTypes.STASIS;
  
  public void DoAction(Clock clock, ArrayList<Cell> cells) {
     var type = _Dna.GetActionOfDnaStrand(clock);
     currentType = type;
     var speed = 3;
     
     if (type != DnaStrandTypes.STASIS) {
       var r = floor(random(0, 4));
       if (r == 0 && _Position.x + speed < width) _Position = new PVector(_Position.x + speed, _Position.y);
       if (r == 1 && _Position.x - speed > 0) _Position = new PVector(_Position.x - speed, _Position.y);
       if (r == 2 && _Position.y + speed < height) _Position = new PVector(_Position.x, _Position.y + speed);
       if (r == 3 && _Position.y - speed > 0) _Position = new PVector(_Position.x, _Position.y - speed);
     }
     
     if (IsVirus()) {
       if (oldType != currentType) {;
         _FoodTick++;
         if (_FoodTick >= _DieWhenNotFedTickCount) {
           cells.remove(this);
         }
       }
     }
     
     if (IsCytotoxicTcell()) {
       if (oldType != currentType) {
         _FoodTick++;
         if (_FoodTick >= _DieWhenNotFedTickCount) {
           Cell cell = new Cell(false);
           cell.SetPosition(_Position);
           cells.add(cell);
           cells.remove(this);
         }
       }
     }
     
     if (type == DnaStrandTypes.FIND && IsCytotoxicTcell()) {
       Cell cell = GetNearestVirusCell(cells);
       if (cell != null) {
         var tempPos = new PVector(cell.getPosition().x, cell.getPosition().y);
         var direction = tempPos.sub(getPosition()).normalize();
         var directionSpeed = new PVector(direction.x * speed, direction.y * speed);
         _Position = getPosition().add(directionSpeed);
       }
     }
     
     if (type == DnaStrandTypes.FIND && IsVirus()) {       
       Cell cell = GetNearestNormalCell(cells);
       if (cell != null) {
         var tempPos = new PVector(cell.getPosition().x, cell.getPosition().y);
         var direction = tempPos.sub(getPosition()).normalize();
         var directionSpeed = new PVector(direction.x * speed, direction.y * speed);
         _Position = getPosition().add(directionSpeed);
       }
     }
     
     if (type == DnaStrandTypes.ABSORB && IsVirus()) {
       RemoveTouchingNormalCell(cells);
     }
     
     if (type == DnaStrandTypes.INFUSE && IsVirus()) {
       IntegrateIntoTouchingCell(cells);
     }
     
     if (type == DnaStrandTypes.ABSORB && IsCytotoxicTcell()) {
       RemoveTouchingVirusCell(cells);
     }
     
     if (type == DnaStrandTypes.BREED && !IsVirus() && !IsCytotoxicTcell()) {
       if (_IntegratedCell != null && _IntegratedCell.IsVirus()) { 
         for (int i = 0; i < 5; i++) {
          var cell = new Cell(false);
          cell.SetDna(_IntegratedCell.GetDna());
          cell.SetPosition(_Position);
          cells.add(cell);
         }
          cells.remove(this);
       }
     }
     
     oldType = currentType;
  }
  
  private Cell GetNearestVirusCell(ArrayList<Cell> cells) {
    
    Cell cloasestCell = null;
    float closestDistance = -1;
    
    for (int i = 0; i < cells.size(); i++) {
      if (cells.get(i).IsVirus()) {

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
  
  private Cell GetNearestNormalCell(ArrayList<Cell> cells) {
    
    Cell cloasestCell = null;
    float closestDistance = -1;
    
    for (int i = 0; i < cells.size(); i++) {
      if (!cells.get(i).IsVirus() && !cells.get(i).IsCytotoxicTcell() && !cells.get(i).HasIntegratedVirusCell()) {

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
  
  private void RemoveTouchingNormalCell(ArrayList<Cell> cells) {
    for (int i = 0; i < cells.size(); i++) {
      if (!cells.get(i).IsVirus() && !cells.get(i).IsCytotoxicTcell() && !cells.get(i).HasIntegratedVirusCell()) {
          var x = _Position;
         float thisDistance = _Position.dist(cells.get(i).getPosition());
           if (thisDistance < _Size / 2) {
             cells.remove(cells.get(i));
             _FoodTick = 0;
           }
      }
    }
  }
  
  private void RemoveTouchingVirusCell(ArrayList<Cell> cells) {
    for (int i = 0; i < cells.size(); i++) {
      if (cells.get(i).IsVirus()) {
         float thisDistance = _Position.dist(cells.get(i).getPosition());
           if (thisDistance < _Size / 2) {
             cells.remove(cells.get(i));
             _FoodTick = 0;
           }
      }
    }
  }
  
  private void IntegrateIntoTouchingCell(ArrayList<Cell> cells) {
    for (int i = 0; i < cells.size(); i++) {
      if (!cells.get(i).IsVirus() && !cells.get(i).IsCytotoxicTcell() && !cells.get(i).HasIntegratedVirusCell() ) {
         float thisDistance = _Position.dist(cells.get(i).getPosition());
         if (thisDistance < _Size / 2) {
           cells.get(i).SetIntegrationCell(this);
           cells.get(i).GetDna().DnaStrand.Add(DnaStrandTypes.BREED);
           cells.remove(this);
         }
      }
    }
  }
  
  public int GetSize() {
    return _Size;
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
  
   public void SetDna(Dna dna) {
    _Dna = dna;
  }
  
  public Dna GetDna() {
    return _Dna;
  }
  
  public Cell GetIntegratedCell() {
    return _IntegratedCell;
  }
  
  public boolean IsCytotoxicTcell() {
    for (int s = 0; s < GetDna().DnaStrand.Count(); s++) {
      if (GetDna().DnaStrand.GetStrandsInArrayFormat()[s] == DnaStrandTypes.ERREDICATE) return true;
    }
    
    return false;
  }
  
  public boolean IsVirus() {
    for (int s = 0; s < GetDna().DnaStrand.Count(); s++) {
      if (GetDna().DnaStrand.GetStrandsInArrayFormat()[s] == DnaStrandTypes.INFECTED) return true;
    }
    
    return false;
  }
  
  public void SetIntegrationCell(Cell cell) {
    _IntegratedCell = cell;
  }
  
  public boolean HasIntegratedVirusCell() {
    var integratedCell = _IntegratedCell;
    if (integratedCell == null) return false;
    if (integratedCell.IsVirus()) return true;
    
    return false;
  }
}
