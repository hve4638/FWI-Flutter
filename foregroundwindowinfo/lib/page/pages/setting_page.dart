import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';
import 'package:wininfo/page/navigate_page/navigate_page.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import 'package:wininfo/page/pages/win_tracer/win_tracer.dart';
import '/timer/intervalevent.dart';
import 'setting_pages/main_page.dart';
import 'setting_pages/setting_navigator.dart';
import './setting_pages/setting_sub_page.dart';

class SettingPage extends SettingNavigatorWidget implements WinTracerWidget {
  const SettingPage({
    Key? key,
    required this.onInitState,
    required this.config,
    required this.aliasDictionary,
  }) : super(key: key);
  final Function onInitState;
  final FwiConfig config;
  final AliasDictionary aliasDictionary;

  @override
  State<SettingNavigatorWidget> createState() => SettingPageState();
}

class SettingPageState extends SettingNavigatorWidgetState<SettingPage> with Later implements WinTracer {
  final titleSize = 32.0;
  final _titleNames = <String>[];
  final _subpages = <SettingSubPage>[];
  NavigatorState? navigatorState;
  var _titles = <Widget>[];
  SettingSubPage? mainPage;

  @override
  void initState() {
    super.initState();

    mainPage = MainPage(
      config : widget.config,
      aliasDictionary: widget.aliasDictionary,
    );
    _titles.add( getTitleWidget("설정", context: context) );
    _subpages.add( mainPage! );

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

    print("setting disable");
  }
}










