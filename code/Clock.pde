public class Clock {
  private String[] _Days = { "SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATERDAY" };
  private int _ClockSpeed = 1;
  
  public Clock(int clockSpeed) {
    _ClockSpeed = clockSpeed;
  }
  
  public void PrintDate() {
    print(GetDayName() + " | " + GetClockTimeHours() + ":" + GetClockTimeMinutes() + ":" + GetClockTimeSeconds());
    println();
  }
  
  public String GetDayName() {
    return _Days[GetClockTimeDays()];
  }
  
  public int GetClockTimeDays() {
    return GetGameTimeDays() % 7;
  }
  
  public int GetClockTimeHours() {
    return GetGameTimeHours() % 24;
  }
  
  public int GetClockTimeMinutes() {
    return GetGameTimeMinutes() % 60;
  }
  
  public int GetClockTimeSeconds() {
    return GetGameTimeSeconds() % 60;
  }
  
  private int GetGameTimeDays() {
    return floor(GetGameTimeHours() / 24);
  }
  
  private int GetGameTimeHours() {
    return floor(GetGameTimeMinutes() / 60);
  }
  
  private int GetGameTimeMinutes() {
    return floor(GetGameTimeSeconds() / 60);
  }
  
  private int GetGameTimeSeconds() {
    return millis() * _ClockSpeed / 1000;
  }
  
}
