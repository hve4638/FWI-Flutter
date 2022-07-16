import './fwi.dart';

class ForegroundWindowInfo implements FWI {
  bool isRunning = false;
  String _title = "Unknown";
  String _name = "Unknown";
  String ?_alias;
  String _path = "Unknown";
  String _time = "00:00:00";
  DateTime _date = DateTime.now();

  @override
  get title => _title;
  @override
  get name => _alias ?? _name;
  @override
  get path => _path;
  @override
  get time => _time;
  @override
  get date => _date;
  @override
  get actualName => _name;
  @override
  get alias => _alias ?? "unknown";

  void set({
    String ?title,
    String ?name,
    String ?alias,
    String ?time,
    String ?path,
    DateTime ?date,
  }) {
    if (title != null) _title = title;
    if (name != null) _name = name;
    if (path != null) _path = path;
    if (date != null) _date = date;
    if (time != null) _time = time;

    _alias = alias;
  }

  setTime({
    required String time
  }) {
    _time = time;
  }

  set title(String title) {
    _title = title;
  }

  void copy(ForegroundWindowInfo source) {
    isRunning = source.isRunning;
    set(
      title: source.title,
      name: source.actualName,
      time: source.time,
      date: source.date,
      alias: source.alias,
      path: source.path,
    );
  }
}