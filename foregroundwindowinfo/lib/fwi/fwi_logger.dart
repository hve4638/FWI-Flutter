import 'dart:io';
import '../fwiconfig/global_config.dart';
import 'log/timeline_log.dart';
import 'log/rank_log.dart';
import 'fwi/fwi.dart';
import '/timer/interval_event.dart';
import './log/max_time_event.dart';
import './trace_logger.dart';

class FwiLogger implements TraceLogger {
  final TimelineLog timelineLog;
  final RankLog rankLog;
  final String Function() getCurrentTimeFormat;
  final config = GlobalConfig();

  MaxTimeEvent? maxTimeEvent;
  var rankUpdateEvent = IntervalEvent();
  DateTime rankLastDate = DateTime(0);
  int changeCount = 0;
  File? file;

  FwiLogger(name, {
    required FWI foregroundWindowInfo,
    required this.getCurrentTimeFormat,
    required this.timelineLog,
    required this.rankLog,
  }) {
    file = File("log/$name");
    maxTimeEvent = MaxTimeEvent(
      onAdd: (info) {
        timelineLog.add(info);
      },
      getCurrentTimeFormat : getCurrentTimeFormat,
      currentInfo: foregroundWindowInfo,
    );
  }

  @override
  start() {
    rankLastDate = DateTime.now();
    rankUpdateEvent.start(100, () {
      var now = DateTime.now();

      var sec = now.difference(rankLastDate).inSeconds;
      if (sec >= 1) {
        rankLastDate = now;
        rankLog.addTime(sec);
      }
    });

    maxTimeEvent?.setIntervalTime(duration: Duration( minutes: config.fwiConfig.timelineWriteDuration ));
    maxTimeEvent?.start();
  }

  @override
  stop() {
    rankUpdateEvent.stop();
    maxTimeEvent?.stop();
  }

  add(FWI foregroundWindowInfo) async {
    var title = foregroundWindowInfo.title.replaceAll("\n", "");
    var date = foregroundWindowInfo.date;
    var name = foregroundWindowInfo.name;

    maxTimeEvent?.addInfo(foregroundWindowInfo);

    rankLastDate = DateTime.now();
    rankLog.setCurrentFwi(foregroundWindowInfo);
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
    return timelineLog.toList(start, end);
  }

  getListLength() {
    return timelineLog.length;
  }

  getRankList() {
    return rankLog.toList();
  }
}


