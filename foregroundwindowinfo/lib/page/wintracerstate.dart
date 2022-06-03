import 'package:flutter/material.dart';

class WinTracerWidget extends StatefulWidget {
  const WinTracerWidget({
    Key? key,
    required this.onInitState,
  }) : super(key: key);
  final Function onInitState;

  static WinTracerState? of(BuildContext context) =>
      context.findAncestorStateOfType<WinTracerState>();

  @override
  State<WinTracerWidget> createState() => WinTracerState();
}

class WinTracerState<T extends WinTracerWidget> extends State<T> {
  enableTrace() {}
  disableTrace() {}

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.onInitState(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

