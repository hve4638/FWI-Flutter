class ForegroundWindowInfo {
  bool isRunning = false;
  String title = "Unknown";
  String name = "Unknown";
  String path = "Unknown";
  String time = "00:00:00";

  void copy(ForegroundWindowInfo source) {
    isRunning = source.isRunning;
    title = source.title;
    name = source.name;
    path = source.path;
    time = source.time;
  }

  //get isRunning => _isRunning;
  //get title => _title;
  //get name => _name;
  //get path => _path;
  //get time => _time;
}