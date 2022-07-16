import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/fwi_config_readonly.dart';

import '/fwi/fwi.dart';
import './win_tracer/win_tracer_stful.dart';
import '/foregroundwindowinfo/foreground_window_info.dart';
import '/timer/interval_event.dart';

import 'package:wininfo/fwiconfig/config_container.dart';


class TestPage extends WinTracerStatefulWidget {
  TestPage({
    Key? key,
    required onInitState,
    required this.foregroundWindowInfo,
    required this.onToggle,
  }) : super(key: key, onInitState : onInitState);
  final FWI foregroundWindowInfo;
  final Function onToggle;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends WinTracerState<TestPage> {
  var event = IntervalEvent();
  var info = ForegroundWindowInfo();
  var _configTraceUpdateTime = 0;
  var _configTimelineUpdateTime = 0;
  var _configRankUpdateTime = 0;
  var _ipsText = "";
  var _ipsCount = -1;
  var testMap = { "test" : "test1" };

  @override
  onEnable() {
    event.start(100, () {
      setState(() {
        info.copy(widget.foregroundWindowInfo);
        _configTraceUpdateTime = widget.config.traceUpdateTime;
        _configTimelineUpdateTime = widget.config.timelineUpdateTime;
        _configRankUpdateTime = widget.config.rankUpdateTime;
      });
    });
  }

  @override
  onDisable() {
    event.stop();
  }

  @override
  void initState() {
    super.initState();
    info.copy(widget.foregroundWindowInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
              child: Column(
                  children: [
                    const Text("Trace Info"),
                    Text("title: ${info.title}"),
                    Text("name: ${info.name}"),
                    Text("path: ${info.path}"),
                    Text("isRunning: ${info.isRunning}"),
                    Text("time: ${info.time}"),
                  ]
              )
          ),
        ),
        Expanded(
          child: Center(
              child: Column(
                  children: [
                    const Text("Config Info"),
                    Text("trace update time: $_configTraceUpdateTime"),
                    Text("timeline update time: $_configTimelineUpdateTime"),
                    Text("rank update time: $_configRankUpdateTime"),
                  ]
              )
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              children: [
                const Text("Map SetState Test"),
                Text("${testMap['test']}"),
                Button(
                  onPressed : () {
                    setState(() {
                      testMap['test'] = "test2";
                    });
                  },
                  child : Text("push")
                ),
              ]
            )
          ),
        ),
        Expanded(
          child : Center(
              child: Column(
                  children: [
                    const Text("IgnoreProcess Set"),
                    Text(_ipsText),
                    Text("count: $_ipsCount"),
                    Button(
                        onPressed : () {
                          var ips = ConfigContainer.ignoreProcesses(context)!;
                          var text = "";
                          for(var name in ips.toList()) {
                            text += name + " ";
                          }
                          setState(() {
                            _ipsText = text;
                            _ipsCount = ips.length;
                          });
                        },
                        child : Text("push")
                    ),
                  ]
              )
          )
        )
      ],
    );
  }
}
