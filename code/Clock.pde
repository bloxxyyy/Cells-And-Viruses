public class Clock {
  private String[] _Days = { "SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATERDAY" };
  private String[] _Months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };
  
   // No leap years since we do not count years.
  private long[] _MonthDayCount = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    
  private int _ClockSpeed = 1;
  private long _PreviousMonth = 0;
  
  public Clock(int clockSpeed) {
    _ClockSpeed = clockSpeed;
  }
  
  public void PrintDate() {
    print(GetMonthName() + " | " + GetDayName() + " | " + GetClockTimeDays() + " | " + GetClockTimeHours() + ":" + GetClockTimeMinutes() + ":" + GetClockTimeSeconds());
    println();
  }
  
  public String GetMonthName() {
    return _Months[Math.toIntExact(GetClockTimeMonths())];
  }
  
  public String GetDayName() {
    return _Days[Math.toIntExact(GetClockTimeDays())];
  }
  
  public long GetClockTimeMonths() {
    _PreviousMonth = GetGameTimeMonths() % 12;
    return GetGameTimeMonths() % 12;
  }
  
  public long GetClockTimeDays() {
    return GetGameTimeDays() % 7;
  }
  
  public long GetClockTimeHours() {
    return GetGameTimeHours() % 24;
  }
  
  public long GetClockTimeMinutes() {
    return GetGameTimeMinutes() % 60;
  }
  
  public long GetClockTimeSeconds() {
    return GetGameTimeSeconds() % 60;
  }
  
  private long GetGameTimeMonths() {
    var nextMonthIndex = _PreviousMonth + 1;
    if (_MonthDayCount.length >= nextMonthIndex) nextMonthIndex = 0;
    
    return floor(GetGameTimeDays() / _MonthDayCount[Math.toIntExact(nextMonthIndex)]);
  }
  
  private long GetGameTimeDays() {
    return floor(GetGameTimeHours() / 24);
  }
  
  private long GetGameTimeHours() {
    return floor(GetGameTimeMinutes() / 60);
  }
  
  private long GetGameTimeMinutes() {
    return floor(GetGameTimeSeconds() / 60);
  }
  
  private long GetGameTimeSeconds() {
    long nextMilles = millis();
    return (nextMilles * _ClockSpeed) / 1000;
  }
  
}
