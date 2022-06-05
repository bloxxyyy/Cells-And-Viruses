public class RedBloodCell implements ICell, IPosition {
  private PVector _Position;
  private String _Name;
  
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
}
