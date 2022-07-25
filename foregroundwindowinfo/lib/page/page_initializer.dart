import '../fwi/fwi/fwi.dart';
import '/fwi/foreground_window_tracer.dart';
import '../fwi/fwi/fwi_readonly.dart';

import '../fwiconfig/global_config.dart';
import './pages/run_page.dart';
import './pages/rank_page.dart';
import './pages/test_page.dart';
import './pages/empty_page.dart';
import './pages/timeline_page.dart';
import './pages/setting_page.dart';
import './pages/export_page.dart';
import './pages/about_page.dart';
import './navigate_page/navigate_page.dart';

class PageInitializer {
  final config = GlobalConfig();
  final Function onInitState;
  final Function toggleTrace;
  FWI ?foregroundWindowInfo;
  ForegroundWindowTracer foregroundWindowTracer;

  PageInitializer({
    required this.onInitState,
    required this.toggleTrace,
    required this.foregroundWindowTracer,
  }) {
    foregroundWindowInfo = foregroundWindowTracer.info();
  }

  runPage() {
    return RunPage(
        onInitState : onInitState,
        foregroundWindowInfo : foregroundWindowInfo!,
        onToggle: toggleTrace
    );
  }

  emptyPage() {
    return EmptyPage(
      onInitState : onInitState,
      foregroundWindowInfo : foregroundWindowInfo!,
      onToggle: toggleTrace,
    );
  }

  testPage() {
    return TestPage(
      onInitState : onInitState,
      foregroundWindowInfo : foregroundWindowInfo!,
      onToggle: toggleTrace
    );
  }

  timelinePage() {
    return TimelinePage(
      onInitState : onInitState,
      foregroundWindowTracer : foregroundWindowTracer,
      toggleTrace: toggleTrace
    );
  }

  rankPage() {
    return RankPage(
      onInitState : onInitState,
      foregroundWindowTracer : foregroundWindowTracer,
      onToggle: toggleTrace
    );
  }

  settingPage() {
    return SettingPage(
      onInitState : onInitState,
    );
  }

  exportPage() {
    return ExportPage(
      onInitState : onInitState,
      foregroundWindowTracer : foregroundWindowTracer,
    );
  }

  aboutPage() {
    return AboutPage(
      onInitState : onInitState,
    );
  }
}


