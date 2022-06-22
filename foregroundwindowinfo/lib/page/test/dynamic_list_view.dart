/*
import 'package:fluent_ui/fluent_ui.dart';
import '/foregroundwindowinfo/foreground_window_tracer.dart';
import '/foregroundwindowinfo/foreground_window_info.dart';
import '/foregroundwindowinfo/trace_logger.dart';
import '/timer/intervalevent.dart';
import 'win_tracer.dart';

class LogPage extends WinTracerWidget {
  LogPage({
    Key? key,
    required onInitState,
    required this.foregroundWindowTracer,
    required this.onToggle
  }) : super(key: key, onInitState : onInitState) {
    logger = foregroundWindowTracer.logger;
  }
  final ForegroundWindowTracer foregroundWindowTracer;
  final Function onToggle;
  TraceLogger ?logger;

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends WinTracerState<LogPage> {
  _LogPageState();
  static const int extraItemCount = 50;
  static const int updateLineRange = 20;
  static const int listItemHeight = 45;
  var _listLastChanged = DateTime.now();
  int _nextUpdateLine = 0;
  int _previousUpdateLine = 0;
  var _isFirst = false;
  var _isLast = false;

  final _scrollController = ScrollController();
  List<Widget> textList = [];
  var _onTraceRealTime = false;
  num _listBeginIndex = 0;
  num _listEndIndex = 0;
  int get viewAmount {
    return _scrollController.position.extentInside ~/ listItemHeight;
  }
  double get listPosition {
    return _scrollController.offset;
  }
  int get listCurrentIndex {
    return listPosition ~/ listItemHeight;
  }

  updateList() {
    var offset = listPosition;
    var currentIndex = offset ~/ listItemHeight;
    int st = currentIndex - extraItemCount;
    int ed = currentIndex + viewAmount + extraItemCount;

    _isFirst = (st <= 0);
    if (_isFirst) {
      st = 0;
    }

    var logger = widget.foregroundWindowTracer.logger;
    var _list = logger.getList(st, ed);

    _isLast = (ed-st > _list.length);
    if (_isLast) ed = st + _list.length as int;

    var interval = (_listBeginIndex - st) * listItemHeight;
    _scrollController.jumpTo(offset+interval);

    _listBeginIndex = st;
    _listEndIndex = ed;
    setUpdateLine(currentIndex);

    setState(() {
      textList = _list;
    });
  }

  setUpdateLine(int offset) {
    _previousUpdateLine = (offset - updateLineRange) * listItemHeight;
    _nextUpdateLine = (offset + viewAmount + updateLineRange) * listItemHeight;
  }

  var event = IntervalEvent();

  @override
  enableTrace() {
    updateList();

    event.start(100, () {
      var offset = listPosition;
      if ((!_isFirst && offset <= _previousUpdateLine) || (!_isLast && offset >= _nextUpdateLine)) {
        updateList();
      }
    });
  }

  @override
  disableTrace() {
    event.stop();
  }

  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            flex: 20,
            child : Container(
              padding : const EdgeInsets.all(20.0),
              color: Colors.blue,
              child : Row(
                children: [
                  ToggleButton(
                      child: const Text('실시간'),
                      checked: _onTraceRealTime,
                      onChanged: (value) {
                        setState() {
                          _onTraceRealTime = value;
                        }
                      }
                  ),
                  const SizedBox( width : 10, ),
                  Button(
                    onPressed: updateList,
                    child : const Icon(FluentIcons.reset),
                  ),
                  const SizedBox( width : 10, ),
                  Button(
                    onPressed: () {
                      widget.foregroundWindowTracer.testPush();
                    },
                    child : const Text("test"),
                  ),
                ],
              ),
            )
        ),
        Flexible(
            flex: 75,
            child : Container(
              padding : const EdgeInsets.all(20.0),
              child : ListView(
                controller: _scrollController,
                children: textList,
              ),
            )
        ),
        Flexible(
            flex: 5,
            child : Container(
              padding : const EdgeInsets.all(20.0),
              color: Colors.blue,
            )
        ),
      ],
    );
  }
}
*/