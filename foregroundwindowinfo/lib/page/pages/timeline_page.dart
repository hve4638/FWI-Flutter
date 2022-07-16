import 'package:fluent_ui/fluent_ui.dart';

import 'package:wininfo/fwiconfig/fwi_config_readonly.dart';
import 'package:wininfo/foregroundwindowinfo/foreground_window_tracer.dart';
import 'package:wininfo/foregroundwindowinfo/trace_logger.dart';
import 'package:wininfo/timer/interval_event.dart';
import 'win_tracer/win_tracer_stful.dart';

class TimelinePage extends WinTracerStatefulWidget {
  TimelinePage({
    Key? key,
    required onInitState,
    required this.foregroundWindowTracer,
    required this.onToggle,
    required this.config
  }) : super(key: key, onInitState : onInitState) {
    getTimelineList = foregroundWindowTracer.getTimelineList;
  }
  final FwiConfigReadonly config;
  final ForegroundWindowTracer foregroundWindowTracer;
  final Function onToggle;
  List<Widget> Function([int, int])? getTimelineList;
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
    var _list = widget.getTimelineList!();

    setState(() {
      itemList = _list;
    });
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
    return Container(
      child: Column(
        children: [
          Container(
              height : 70,
              //color : Colors.red,
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text("타임라인",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
          ),
          Container(
            height: 70,
            padding : const EdgeInsets.all(20.0),
            child : Row(
              children: [
                Button(
                  onPressed: updateList,
                  child : const Icon(FluentIcons.reset),
                ),

                const SizedBox( width : 10, ),
                ToggleButton(
                  child: const Text('실시간'),
                  checked: widget.enableTrace,
                  onChanged: setTraceRealTime,
                ),
              ],
            ),
          ),
          Expanded(
              child : Container(
                padding : const EdgeInsets.all(20.0),
                child : ListView(
                  controller : _scrollController,
                  children: itemList,
                ),
              )
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
