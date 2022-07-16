import '/fwi/foreground_window_info.dart';
import '/fwi/foreground_window_tracer.dart';
import '/fwi/fwi.dart';

import '../fwiconfig/global_config.dart';
import './pages/run_page.dart';
import './pages/rank_page.dart';
import './pages/test_page.dart';
import './pages/empty_page.dart';
import './pages/timeline_page.dart';
import './pages/setting_page.dart';
import './navigate_page/navigate_page.dart';

class PageInitializer {
  final config = GlobalConfig();
  final Function onInitState;
  final Function onToggle;
  ForegroundWindowInfo ?foregroundWindowInfo;
  ForegroundWindowTracer foregroundWindowTracer;

  PageInitializer({
    required this.onInitState,
    required this.onToggle,
    required this.foregroundWindowTracer,
  }) {
    foregroundWindowInfo = foregroundWindowTracer.info();
  }

  runPage() {
    return RunPage(
        onInitState : onInitState,
        foregroundWindowInfo : foregroundWindowInfo!,
        onToggle: onToggle
    );
  }

  emptyPage() {
    return EmptyPage(
      onInitState : onInitState,
      foregroundWindowInfo : foregroundWindowInfo!,
      onToggle: onToggle,
    );
  }

  testPage() {
    return TestPage(
      onInitState : onInitState,
      foregroundWindowInfo : foregroundWindowInfo!,
      onToggle: onToggle
    );
  }

  timelinePage() {
    return TimelinePage(
      onInitState : onInitState,
      foregroundWindowTracer : foregroundWindowTracer,
      onToggle: onToggle
    );
  }

  rankPage() {
    return RankPage(
      onInitState : onInitState,
      foregroundWindowTracer : foregroundWindowTracer,
      onToggle: onToggle
    );
  }

  settingPage() {
    return SettingPage(
      onInitState : onInitState,
    );
  }
}


