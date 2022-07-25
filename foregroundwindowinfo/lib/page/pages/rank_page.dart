import 'package:fluent_ui/fluent_ui.dart';

import '../../fwiconfig/global_config.dart';
import '/fwi/foreground_window_tracer.dart';
import '/fwi/fwi.dart';
import '/fwi/trace_logger.dart';
import '/timer/interval_event.dart';
import 'win_tracer/win_tracer_stful.dart';

class RankPage extends WinTracerStatefulWidget {
  RankPage({
    Key? key,
    required onInitState,
    required this.foregroundWindowTracer,
    required this.onToggle,
  }) : super(key: key, onInitState : onInitState) {
    getRankList = foregroundWindowTracer.getRankList;
  }
  final ForegroundWindowTracer foregroundWindowTracer;
  final Function onToggle;
  List<Widget> Function()? getRankList;
  double lastScrollPosition = 0;
  bool enableTrace = false;

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends WinTracerState<RankPage> {
  final globalText = GlobalText();
  final config = GlobalConfig();

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
      event.start(config.fwiConfig.rankUpdateDuration, () {
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
                Text(globalText["PAGE_RANK"],
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
      ],
    );
  }
}
