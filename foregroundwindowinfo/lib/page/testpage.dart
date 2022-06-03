import 'package:flutter/material.dart';
import '/windowinfo/foregroundwindowinfo.dart';
import '/timer/intervalevent.dart';
import 'wintracerstate.dart';

class TestPage extends WinTracerWidget {
  TestPage({
    Key? key,
    required onInitState,
    required this.foregroundWindowInfo,
    required this.onToggle
  }) : super(key: key, onInitState : onInitState);
  final ForegroundWindowInfo foregroundWindowInfo;
  final Function onToggle;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends WinTracerState<TestPage> {
  var event = IntervalEvent();
  var info = ForegroundWindowInfo();

  enableTrace() {
    event.start(100, () {
      setState(() {
        info.copy(widget.foregroundWindowInfo);
      });
    });
  }

  disableTrace() {
    event.stop();
  }

  @override
  void initState() {
    super.initState();
    info.copy(widget.foregroundWindowInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("TestPage"),
          Text("title: ${info.title}"),
          Text("name: ${info.name}"),
          Text("path: ${info.path}"),
          Text("isRunning: ${info.isRunning}"),
          Text("time: ${info.time}"),
        ],
      ),
    );
  }
}
