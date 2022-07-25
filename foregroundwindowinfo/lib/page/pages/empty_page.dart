import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwi/fwi.dart';
import 'win_tracer/win_tracer_stful.dart';

class EmptyPage extends WinTracerStatefulWidget {
  const EmptyPage({
    Key? key,
    required onInitState,
    required FWIReadOnly foregroundWindowInfo,
    required this.onToggle
  }) : super(key: key, onInitState : onInitState);
  final Function onToggle;

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends WinTracerState<EmptyPage> {
  @override
  onEnable() {
    print("Enable EmptyPage");
  }

  @override
  onDisable() {
    print("Disable EmptyPage");
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


