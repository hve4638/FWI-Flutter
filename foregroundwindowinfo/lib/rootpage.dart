import 'package:fluent_ui/fluent_ui.dart';
import '/windowinfo/foregroundwindowtracer.dart';

import 'pages.dart';
import 'pagelist.dart';
import 'timer/intervalevent.dart';
import 'page/wintracerstate.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  static RootPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<RootPageState>();

  @override
  State<RootPage> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  final _tracer = ForegroundWindowTracer();
  final _pages = PageList();
  int _pageIndex = 0;
  WinTracerState? _currentState;
  IntervalEvent? timer;

  RootPageState({ Key? key }) {
    var pages = Pages(
      onInitState : (state) {
        _currentState = state;
        enableCurrentPage();
      },
      onToggle : toggle,
      foregroundWindowInfo: _tracer.info(),
    );

    _pages.add(
        title : "Main",
        icon: const Icon(FluentIcons.home),
        widget: pages.runPage()
    );
    _pages.add(
        title : "Test",
        icon: const Icon(FluentIcons.clock),
        widget: pages.testPage()
    );
    _pages.add(
        title : "Empty",
        icon: const Icon(FluentIcons.settings),
        widget: pages.emptyPage()
    );
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
    _currentState?.enableTrace();
  }

  disableCurrentPage() {
    _currentState?.disableTrace();
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
          items : _pages.paneitems(),
        ),
        content: NavigationBody(
          index: _pageIndex,
          children: _pages.widgets(),
        ),
      )
    );
  }
}
