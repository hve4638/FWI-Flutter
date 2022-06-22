import 'package:fluent_ui/fluent_ui.dart';

import 'package:wininfo/fwiconfig/fwi_config_readonly.dart';
import 'package:wininfo/foregroundwindowinfo/foreground_window_tracer.dart';
import 'package:wininfo/foregroundwindowinfo/trace_logger.dart';
import 'package:wininfo/timer/intervalevent.dart';
import 'win_tracer/win_tracer_stful.dart';

class TimelinePage extends WinTracerStatefulWidget {
  TimelinePage({
    Key? key,
    required onInitState,
    required this.foregroundWindowTracer,
    required this.onToggle,
    required this.config
  }) : super(key: key, onInitState : onInitState) {
    logger = foregroundWindowTracer.logger;
  }
  final FwiConfigReadonly config;
  final ForegroundWindowTracer foregroundWindowTracer;
  final Function onToggle;
  TraceLogger ?logger;
  double lastScrollPosition = 0;
  bool enableTrace = false;

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends WinTracerState<TimelinePage> {
  int ?listChangeNumber;
  final _scrollController = ScrollController();
  final event = IntervalEvent();
  List<Widget> itemList = [];

  updateList() {
    var logger = widget.logger!;

    if (logger.isListChanged(listChangeNumber)) {
      listChangeNumber = logger.listChangeNumber;

      var _list = widget.logger?.getList();
      setState(() {
        itemList = _list;
      });
    }
  }

  setTraceRealTime(value) {
    setState(() {
      widget.enableTrace = value;
    });

    if (value) {
      event.start(widget.config.timelineUpdateTime, () {
        updateList();
      });
    } else {
      event.stop();
    }
  }

  @override
  onEnable() {
    _scrollController.jumpTo(widget.lastScrollPosition);
    updateList();
    setTraceRealTime(widget.enableTrace);
  }

  @override
  onDisable() {
    widget.lastScrollPosition = _scrollController.offset;
    event.stop();
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
                    checked: widget.enableTrace,
                    onChanged: setTraceRealTime,
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
                controller : _scrollController,
                children: itemList,
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
