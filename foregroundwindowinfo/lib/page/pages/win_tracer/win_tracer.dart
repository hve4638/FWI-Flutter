import 'package:fluent_ui/fluent_ui.dart';

abstract class WinTracer {
  onEnable();
  onDisable();
}

abstract class WinTracerWidget extends Widget {
  const WinTracerWidget({Key? key}) : super(key: key);
}

class Later {
  laterCall(Function(dynamic) call) {
    WidgetsBinding.instance?.addPostFrameCallback(call);
  }
}