ArrayList<RedBloodCell> RedBloodCells;
ArrayList<Virus> viruses; // for now we keep it at 1 particilar virus. Later more type of viruses should be added.

void setup() {
  size(640, 480);  
  RedBloodCells = new ArrayList<RedBloodCell>();
  viruses = new ArrayList<Virus>();
  SetStartingCells();
  SetStartingVirus();
}

void draw() {
  background(0);
  DisplayRedBloodCells();
  DisplayViruses();
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
  stroke(255);          
  fill(255, 0, 0);
  for (int i = 0; i < RedBloodCells.size(); i++) {
    var cell = RedBloodCells.get(i);
    circle(cell.getPosition().x, cell.getPosition().y, cellSize);
  }
}

void SetStartingVirus() {
  var virus = new Virus();
  virus.SetName("Virus");
  virus.SetPosition(new PVector(random(10, 400), random(10, 400)));
  viruses.add(virus);
}

void DisplayViruses() {
  int cellSize = 16;
  stroke(255);          
  fill(0, 255, 0);
  for (int i = 0; i < viruses.size(); i++) {
    var virus = viruses.get(i);
    circle(virus.getPosition().x, virus.getPosition().y, cellSize);
  }
}
