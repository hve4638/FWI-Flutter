import '/windowinfo/foregroundwindowinfo.dart';
import 'page/runpage.dart';
import 'page/testpage.dart';
import 'page/emptypage.dart';

class Pages {
  Pages({
    required this.onInitState,
    required this.onToggle,
    required this.foregroundWindowInfo,
  });
  final Function onInitState;
  final Function onToggle;
  final ForegroundWindowInfo foregroundWindowInfo;

  runPage() {
    return RunPage(
        onInitState : onInitState,
        foregroundWindowInfo : foregroundWindowInfo,
        onToggle: onToggle,
    );
  }

  emptyPage() {
    return EmptyPage(
      onInitState : onInitState,
      foregroundWindowInfo : foregroundWindowInfo,
      onToggle: onToggle,
    );
  }

  testPage() {
    return TestPage(
      onInitState : onInitState,
      foregroundWindowInfo : foregroundWindowInfo,
      onToggle: onToggle,
    );
  }
}