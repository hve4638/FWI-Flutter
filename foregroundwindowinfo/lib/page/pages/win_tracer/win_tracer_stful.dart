import 'package:flutter/material.dart';
import './win_tracer.dart';

class WinTracerStatefulWidget extends StatefulWidget implements WinTracerWidget {
  const WinTracerStatefulWidget({
    Key? key,
    required this.onInitState,
  }) : super(key: key);
  final Function onInitState;

  static WinTracerState? of(BuildContext context) =>
      context.findAncestorStateOfType<WinTracerState>();

  @override
  State<WinTracerStatefulWidget> createState() => WinTracerState();
}

class WinTracerState<T extends WinTracerStatefulWidget> extends State<T> with Later implements WinTracer {
  @override
  onEnable() {}
  @override
  onDisable() {}

  @override
  void initState() {
    super.initState();

    laterCall((timeStamp) {
      widget.onInitState(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

