abstract class FWI {
  String get title;
  String get name;
  String get path;
  String get time;
  DateTime get date;
  String get actualName;
  String get alias;

  @override
  toString() {
    return "FWI[name:$actualName($alias) title:$title time:$time date:$date]";
  }
}