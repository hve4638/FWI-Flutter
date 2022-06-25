class ForegroundWindowInfo {
  bool isRunning = false;
  String _title = "Unknown";
  String _name = "Unknown";
  String ?_alias;
  String _path = "Unknown";
  String _time = "00:00:00";
  DateTime _date = DateTime.now();
  get title => _title;
  get name => _alias ?? _name;
  get path => _path;
  get time => _time;
  get date => _date;
  get actualName => _name;
  get alias => _alias ?? "unknown";

  void set({
    String ?title,
    String ?name,
    String ?alias,
    String ?time,
    DateTime ?date,
  }) {
    if (title != null) _title = title;
    if (name != null) _name = name;
    if (date != null) _date = date;
    if (time != null) _time = time;

    _alias = alias;
  }

  void copy(ForegroundWindowInfo source) {
    isRunning = source.isRunning;
    _title = source.title;
    _name = source.name;
    _path = source.path;
    _time = source.time;
  }

  //get isRunning => _isRunning;
  //get title => _title;
  //get name => _name;
  //get path => _path;
  //get time => _time;
}