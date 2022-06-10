ArrayList<RedBloodCell> RedBloodCells;
Clock clock = new Clock(600);

void setup() {
  size(640, 480);  
  RedBloodCells = new ArrayList<RedBloodCell>();
  SetStartingCells(); //<>// //<>//
}

void draw() {
  background(0);
  
  for (int i = 0; i < RedBloodCells.size(); i++) {
    var cell = RedBloodCells.get(i);
    DisplayCell(cell, cell.IsVirus());
  }
  
  clock.PrintDate();
}

void SetStartingCells() {
  int cellCount = 10;
 
  for (int i = 0; i < cellCount; i++) {
    var cell = new RedBloodCell();
    
    if (cell.IsVirus()) cell.SetName("Virus Cell");
    else cell.SetName("Red Blood Cell");
    
    cell.SetPosition(new PVector(random(10, 400), random(10, 400)));
    RedBloodCells.add(cell);
  }
}

void DisplayCell(RedBloodCell cell, boolean virus) {
  int cellSize = 16;
  stroke(255);
  
  if (virus) fill(0, 255, 0);
  else  fill(255, 0, 0);
    
  circle(cell.getPosition().x, cell.getPosition().y, cellSize);
}
