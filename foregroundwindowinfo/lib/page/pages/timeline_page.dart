import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwi/foreground_window_tracer.dart';
import 'package:wininfo/fwi/trace_logger.dart';
import 'package:wininfo/timer/interval_event.dart';
import '../../fwiconfig/global_config.dart';
import 'win_tracer/win_tracer_stful.dart';

class TimelinePage extends WinTracerStatefulWidget {
  final ForegroundWindowTracer foregroundWindowTracer;
  final Function toggleTrace;
  List<Widget> Function([int, int])? getTimelineList;
  double lastScrollOffset = 0;
  bool enableTrace = false;

  TimelinePage({
    Key? key,
    required onInitState,
    required this.foregroundWindowTracer,
    required this.toggleTrace
  }) : super(key: key, onInitState : onInitState) {
    getTimelineList = foregroundWindowTracer.getTimelineList;
  }

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends WinTracerState<TimelinePage> {
  final globalText = GlobalText();
  final config = GlobalConfig();

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
      event.start(config.fwiConfig.timelineUpdateDuration, () {
        updateList();
      });
    } else {
      event.stop();
    }
  }

  @override
  onEnable() {
    _scrollController.jumpTo(widget.lastScrollOffset);
    updateList();
    setTraceRealTime(widget.enableTrace);
  }

  @override
  onDisable() {
    widget.lastScrollOffset = _scrollController.offset;
    event.stop();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height : 70,
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(globalText["PAGE_TIMELINE"],
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
                child: Text(globalText["BUTTON_REALTIME"]),
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
    );
  }
}
