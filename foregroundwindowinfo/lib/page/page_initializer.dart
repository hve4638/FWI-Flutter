import '../foregroundwindowinfo/foreground_window_info.dart';
import '../foregroundwindowinfo/foreground_window_tracer.dart';
import '../fwiconfig/fwi_config.dart';
import 'pages/run_page.dart';
import 'pages/rank_page.dart';
import 'pages/test_page.dart';
import 'pages/empty_page.dart';
import 'pages/timeline_page.dart';
import 'pages/setting_pages/setting_main_page.dart';
import './navigate_page/navigate_page.dart';

class PageInitializer {
  PageInitializer({
    required this.onInitState,
    required this.onToggle,
    required this.foregroundWindowTracer,
    required this.config,
  }) {
    foregroundWindowInfo = foregroundWindowTracer.info();
  }
  final Function onInitState;
  final Function onToggle;
  final FwiConfig config;
  ForegroundWindowInfo ?foregroundWindowInfo;
  ForegroundWindowTracer foregroundWindowTracer;

  runPage() {
    return RunPage(
        onInitState : onInitState,
        foregroundWindowInfo : foregroundWindowInfo!,
        onToggle: onToggle,
        config : config.readonly,
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
      onToggle: onToggle,
      config : config.readonly,
    );
  }

  timelinePage() {
    return TimelinePage(
      onInitState : onInitState,
      foregroundWindowTracer : foregroundWindowTracer,
      onToggle: onToggle,
      config: config.readonly
    );
  }

  rankPage() {
    return RankPage(
      onInitState : onInitState,
      foregroundWindowTracer : foregroundWindowTracer,
      onToggle: onToggle,
      config : config.readonly
    );
  }

  settingPage() {
    return NavigatePage(
        child: SettingPage(
          onInitState : onInitState,
          config : config,
        )
    );
  }
}


