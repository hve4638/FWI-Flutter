import 'package:fluent_ui/fluent_ui.dart';
import 'foregroundwindowinfo/foreground_window_tracer.dart';
import 'page/page_initializer.dart';
import 'page/page_list.dart';
import 'timer/intervalevent.dart';
import 'page/pages/win_tracer/win_tracer.dart';
import 'page/pages/win_tracer/win_tracer_stful.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';

class RootPage extends StatefulWidget {
  RootPage({
    Key? key,
    required this.config,
    required this.aliasDictionary,
  }) : super(key: key) {
    tracer = ForegroundWindowTracer(
      config: config.readonly,
      aliasDictionary: aliasDictionary
    );
  }
  final FwiConfig config;
  final AliasDictionary aliasDictionary;
  ForegroundWindowTracer? tracer;

  @override
  State<RootPage> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  final _pages = PageList();
  get _tracer => widget.tracer!;
  int _pageIndex = 0;
  WinTracerState? _currentState;
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
      config : widget.config,
      aliasDictionary : widget.aliasDictionary,
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
    print("Enabled >> $_currentState");
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
      home : NavigationView(
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