ArrayList<Cell> cells;
Clock clock = new Clock(600);

void setup() {
  size(640, 480);  
  cells = new ArrayList<Cell>();
  SetStartingCells(); //<>//
}

void draw() {
  background(0);
  
  for (int i = 0; i < cells.size(); i++) {
    var cell = cells.get(i);
    DisplayCell(cell, cell.IsVirus());
  }
  
  clock.PrintDate();
}

void SetStartingCells() {
  int cellCount = 10;
 
  for (int i = 0; i < cellCount; i++) {
    var cell = new Cell();
    
    if (cell.IsVirus()) cell.SetName("Virus Cell");
    else cell.SetName("Red Blood Cell");
    
    cell.SetPosition(new PVector(random(10, 400), random(10, 400)));
    cells.add(cell);
  }
}

void DisplayCell(Cell cell, boolean virus) {
  int cellSize = 16;
  stroke(255);
  
  if (virus) fill(0, 255, 0);
  else  fill(255, 0, 0);
    
  circle(cell.getPosition().x, cell.getPosition().y, cellSize);
}
