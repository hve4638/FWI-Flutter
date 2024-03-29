import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/alias_dictionary.dart';
import 'package:wininfo/page/navigate_page/navigate_page.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import 'package:wininfo/page/pages/win_tracer/win_tracer.dart';
import '../../fwiconfig/global_config.dart';
import '/timer/interval_event.dart';
import 'setting_pages/main_page.dart';
import 'setting_pages/setting_navigator.dart';
import './setting_pages/setting_sub_page.dart';

class SettingPage extends SettingNavigatorWidget implements WinTracerWidget {
  const SettingPage({
    Key? key,
    required this.onInitState,
  }) : super(key: key);
  final Function onInitState;
  @override
  State<SettingNavigatorWidget> createState() => SettingPageState();
}

class SettingPageState extends SettingNavigatorWidgetState<SettingPage> with Later implements WinTracer {
  final globalText = GlobalText();
  final titleSize = 32.0;
  final _titleNames = <String>[];
  final _subpages = <SettingSubPage>[];
  NavigatorState? navigatorState;
  var _titles = <Widget>[];
  SettingSubPage? mainPage;

  @override
  void initState() {
    super.initState();

    mainPage = MainPage();
    _titles.add( getTitleWidget(globalText["PAGE_SETTING"], context: context, noArrow: true) );
    _subpages.add(mainPage!);

    laterCall((timeStamp) {
      widget.onInitState(this);
    });
  }

  @override
  push<T extends Object?>(BuildContext context, SettingSubPage widget) {
    navigatorState = Navigator.of(context);
    widget.setEventPop(() {
      _navigatorPop();
      refreshTitles();
    });

    _subpages.add(widget);

    navigatorState?.push(
      FluentPageRoute(builder: (context) => widget as Widget)
    );

    _titles.add( getTitleWidget(widget.title, context: context) );
    refreshTitles();
  }

  bool _navigatorPop() {
    if (navigatorState?.canPop() ?? false) {
      navigatorState?.pop();
      _titles.removeLast();

      var subpage = _subpages.removeLast();
      subpage.dispose();

      return true;
    } else {
      return false;
    }
  }

  getTitleWidget(String name, {
    required BuildContext context,
    bool noArrow = false
  }) {
    if (noArrow) {
      return _getTitleButton(name, context: context);
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _getArrow(),
          _getTitleButton(name, context: context),
        ],
      );
    }
  }

  _getArrow() {
    return Column(
      children: [
        const SizedBox(height: 5 ),
        Expanded(
          child: Image.asset("assets/arrow_right.png",
            color: Colors.black,
            width: 18.0,
          ),
        ),
      ],
    );
  }

  _getTitleButton(String name, {
    required BuildContext context
  }) {
    var depth = _titles.length;

    return TextButton(
        onPressed: () {
          while (depth+1 < _titles.length) {
            pop(context);
          }
        },
        child: Text(name,
          style: TextStyle(
            fontSize : titleSize,
          ),
        ),
        style: ButtonStyle(
          foregroundColor: ButtonState.all(Colors.black),
        ),
      );
  }

  @override
  void pop<T>(BuildContext context) {
    _navigatorPop();
    refreshTitles();
  }

  refreshTitles() {
    setState(() {
      _titles = [..._titles];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            height : 80,
            padding: const EdgeInsets.all(15),
            //color : Colors.blue,
            child: Row(
              children: _titles,
            ),
          ),
          Expanded(
            child: NavigatePage(
              child: mainPage as Widget
            )
          )
        ],
      );
  }

  @override
  onEnable() {

  }

  @override
  onDisable() {
    while(_navigatorPop()) {}

    var subpage = _subpages.removeLast();
    subpage.dispose();
    _titles.removeLast();
  }
}










