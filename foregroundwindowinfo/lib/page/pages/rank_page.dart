import 'package:fluent_ui/fluent_ui.dart';

import 'package:wininfo/fwiconfig/fwi_config_readonly.dart';
import '/foregroundwindowinfo/foreground_window_tracer.dart';
import '/foregroundwindowinfo/foreground_window_info.dart';
import '/foregroundwindowinfo/trace_logger.dart';
import '/timer/interval_event.dart';
import 'win_tracer/win_tracer_stful.dart';

class RankPage extends WinTracerStatefulWidget {
  RankPage({
    Key? key,
    required onInitState,
    required this.foregroundWindowTracer,
    required this.onToggle,
    required this.config
  }) : super(key: key, onInitState : onInitState) {
    getRankList = foregroundWindowTracer.getRankList;
  }
  final FwiConfigReadonly config;
  final ForegroundWindowTracer foregroundWindowTracer;
  final Function onToggle;
  List<Widget> Function()? getRankList;
  double lastScrollPosition = 0;
  bool enableTrace = false;

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends WinTracerState<RankPage> {
  DateTime lastUpdate = DateTime.now();
  int ?listChangeNumber;
  final _scrollController = ScrollController();
  final event = IntervalEvent();
  List<Widget> itemList = [];

  updateList() {
    var _list = widget.getRankList!();

    setState(() {
      lastUpdate = DateTime.now();
      itemList = _list;
    });
  }

  setTraceRealTime(value) {
    setState(() {
      widget.enableTrace = value;
    });

    if (value) {
      event.start(widget.config.rankUpdateTime, () {
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
                  const SizedBox( width : 10, ),
                  Text("Last update: $lastUpdate"),
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
