import 'package:flutter/material.dart';
import '/windowinfo/foregroundwindowinfo.dart';
import '/timer/intervalevent.dart';
import 'wintracerstate.dart';

class EmptyPage extends WinTracerWidget {
  const EmptyPage({
    Key? key,
    required onInitState,
    required this.foregroundWindowInfo,
    required this.onToggle
  }) : super(key: key, onInitState : onInitState);
  final ForegroundWindowInfo foregroundWindowInfo;
  final Function onToggle;

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends WinTracerState<EmptyPage> {

}


