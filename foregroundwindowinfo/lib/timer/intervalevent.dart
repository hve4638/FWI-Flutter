import 'dart:async';

class IntervalEvent {
  Timer? timer;
  bool _isRunning = false;
  var _interval = 1000;

  start(int interval, Function? callback) {
    _interval = interval;
    Function call = callback ?? (){};

    timer = Timer.periodic(Duration(milliseconds: _interval), (timer) {
      call();
    });
    _isRunning = true;
  }

  stop() {
    timer?.cancel();
    _isRunning = false;
  }

  bool isRunning() {
    return _isRunning;
  }
}
