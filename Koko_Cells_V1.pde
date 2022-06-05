ArrayList<RedBloodCell> RedBloodCells;

void setup() {
  size(640, 480);  
  RedBloodCells = new ArrayList<RedBloodCell>();
  SetStartingCells();
}

void draw() {
  background(0);
  DisplayRedBloodCells();
}

void SetStartingCells() {
  int cellCount = 40;
 
  for (int i = 0; i < cellCount; i++) {
    var cell = new RedBloodCell();
    cell.SetName("Red Blood Cell Nr: " + i);
    cell.SetPosition(new PVector(random(10, 400), random(10, 400)));
    RedBloodCells.add(cell);
  }
}

void DisplayRedBloodCells() {
  int cellSize = 16;
  stroke(0);          
  fill(255, 0, 0);
  for (int i = 0; i < RedBloodCells.size(); i++) {
    var cell = RedBloodCells.get(i);
    circle(cell.getPosition().x, cell.getPosition().y, cellSize);
  }
}
