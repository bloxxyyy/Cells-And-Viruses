ArrayList<Cell> cells;
Clock clock = new Clock(60);

void setup() {
  size(640, 480);  
  cells = new ArrayList<Cell>();
  SetStartingCells(); //<>// //<>//
 
  
}

void draw() {
  background(0);
  
  for (int i = 0; i < cells.size(); i++) {
    var cell = cells.get(i);
    cell.DoAction(clock, cells);
    DisplayCell(cell, cell.IsVirus(), cell.IsCytotoxicTcell());
  }
  
  //clock.PrintDate();
}

void SetStartingCells() {
  int cellCount = 80;
 
  for (int i = 0; i < cellCount; i++) {
    var cell = new Cell(true);
    
    if (cell.IsVirus()) cell.SetName("Virus Cell");
    if (cell.IsCytotoxicTcell()) cell.SetName("T-Killer Cell");
    else cell.SetName("Red Blood Cell");
    
    cell.SetPosition(new PVector(random(10, 630), random(10, 470)));
    cells.add(cell);
  }
}

void DisplayCell(Cell cell, boolean virus, boolean tKillerCell) {
  stroke(255);
  if (virus) fill(0, 255, 0);
  else if (tKillerCell) fill(255, 255, 255);
  else  fill(255, 0, 0);
    
  circle(cell.getPosition().x, cell.getPosition().y, cell.GetSize());
}
