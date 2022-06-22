import 'dart:io';
import 'log/log_list.dart';
import 'log/log_rank.dart';
import 'foreground_window_info.dart';
import '/timer/intervalevent.dart';

class TraceLogger {
  final list = LogList();
  final rank = LogRank();
  var rankUpdateEvent = IntervalEvent();
  DateTime rankLastDate = DateTime(0);
  int changeCount = 0;
  File ?file;

  start() {
    rankLastDate = DateTime.now();
    rankUpdateEvent.start(100, () {
      var now = DateTime.now();

      var sec = now.difference(rankLastDate).inSeconds;
      if (sec >= 1) {
        rankLastDate = now;
        rank.addTime(sec);
      }
    });
  }

  stop() {
    rankUpdateEvent.stop();
  }

  TraceLogger(name) {
    file = File("log/$name");
  }

  add(ForegroundWindowInfo foregroundWindowInfo) async {
    var title = foregroundWindowInfo.title.replaceAll("\n", "");
    var date = foregroundWindowInfo.date;
    var name = foregroundWindowInfo.name;

    rankLastDate = DateTime.now();
    rank.setInfo(foregroundWindowInfo);
    list.add(foregroundWindowInfo);
    _addFile(title : title, date: date, name: name);
    changeCount++;
  }

  _addFile({
    required title,
    required DateTime date,
    required String name
  }) async {
    await file?.writeAsString("$date|$name|$title\n", mode: FileMode.append);
  }

  bool isListChanged(int ?changeNumber) {
    return changeCount != changeNumber;
  }

  int get listChangeNumber => changeCount;

  getList([int ?start, int ?end]) {
    return list.toList(start, end);
  }

  getListLength() {
    return list.length;
  }

  getRankList() {
    return rank.toList();
  }
}




