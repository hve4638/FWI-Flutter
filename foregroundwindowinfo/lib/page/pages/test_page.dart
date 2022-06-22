import 'package:flutter/material.dart';
import '/foregroundwindowinfo/foreground_window_info.dart';
import '/timer/intervalevent.dart';
import './win_tracer/win_tracer_stful.dart';
import 'package:wininfo/fwiconfig/fwi_config_readonly.dart';
import 'package:fluent_ui/fluent_ui.dart';

class TestPage extends WinTracerStatefulWidget {
  TestPage({
    Key? key,
    required onInitState,
    required this.foregroundWindowInfo,
    required this.onToggle,
    required this.config
  }) : super(key: key, onInitState : onInitState);
  final ForegroundWindowInfo foregroundWindowInfo;
  final Function onToggle;
  final FwiConfigReadonly config;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends WinTracerState<TestPage> {
  var event = IntervalEvent();
  var info = ForegroundWindowInfo();
  var _configTraceUpdateTime = 0;
  var _configTimelineUpdateTime = 0;
  var _configRankUpdateTime = 0;

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
      ],
    );
  }
}
