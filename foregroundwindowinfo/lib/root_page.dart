import 'package:fluent_ui/fluent_ui.dart';
import 'fwi/foreground_window_tracer.dart';
import 'page/page_initializer.dart';
import 'page/page_list.dart';
import 'timer/interval_event.dart';
import 'page/pages/win_tracer/win_tracer.dart';
import 'page/pages/win_tracer/win_tracer_stful.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import 'package:wininfo/fwiconfig/config_container.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';

import 'fwiconfig/global_config.dart';

class RootPage extends StatefulWidget {
  RootPage({
    Key? key
  }) : super(key: key) {
    tracer = ForegroundWindowTracer();
  }
  final config = GlobalConfig();
  ForegroundWindowTracer? tracer;

  @override
  State<RootPage> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  get fwiConfig => widget.config.fwiConfig;
  get ignoreProcesses => widget.config.ignoreProcesses;
  get aliases => widget.config.aliases;

  final _pages = PageList();
  get _tracer => widget.tracer!;
  int _pageIndex = 0;
  WinTracer? _currentState;
  IntervalEvent? timer;

  @override
  void initState() {
    super.initState();

    var pageInitializer = PageInitializer(
      onInitState : (state) {
        _currentState = state;
        enableCurrentPage();
      },
      onToggle : toggle,
      foregroundWindowTracer: _tracer,
    );

    initPageList(_pages, pageInitializer);
  }

  bool toggle() {
    if (_tracer.isRunning()) {
      _tracer.stop();
      return false;
    }
    else {
      _tracer.start();
      return true;
    }
  }

  enableCurrentPage() {
    //print("Enabled >> $_currentState");
    _currentState?.onEnable();
  }

  disableCurrentPage() {
    _currentState?.onDisable();
    _currentState = null;
  }

  @override
  Widget build(BuildContext context) {
    return FluentApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          accentColor: Colors.blue,
          iconTheme: const IconThemeData(size:24),
        ),
        home : ConfigContainer(
          config: fwiConfig.readonly,
          ignoreProcesses: ignoreProcesses,
          aliases : aliases,
          child: NavigationView(
            pane : NavigationPane(
              selected: _pageIndex,
              onChanged: (index) {
                if (_pageIndex != index) {
                  disableCurrentPage();
                  setState(() {
                    _pageIndex = index;
                  });
                }
              },
              displayMode: PaneDisplayMode.auto,
              items : _pages.paneItems(),
            ),
            content: NavigationBody(
              index: _pageIndex,
              children: _pages.widgets(),
            ),
          ),
        )
      );
  }
}

initPageList(PageList pages, PageInitializer pageInitializer) {
  pages.add(
      title : "Main",
      icon: const Icon(FluentIcons.home),
      widget: pageInitializer.runPage()
  );
  pages.add(
      title : "Timeline",
      icon: const Icon(FluentIcons.trackers),
      widget: pageInitializer.timelinePage()
  );
  pages.add(
      title : "Rank",
      icon: const Icon(FluentIcons.list),
      widget: pageInitializer.rankPage()
  );
  pages.add(
      title : "Setting",
      icon: const Icon(FluentIcons.settings),
      widget: pageInitializer.settingPage()
  );
  pages.add(
      title : "Test",
      icon: const Icon(FluentIcons.page),
      widget: pageInitializer.testPage()
  );
  pages.add(
      title : "empty",
      icon: const Icon(FluentIcons.page),
      widget: pageInitializer.emptyPage()
  );
}