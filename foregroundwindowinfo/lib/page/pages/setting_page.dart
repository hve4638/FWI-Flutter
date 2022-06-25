import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/page/navigate_page/navigate_page.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import 'package:wininfo/page/pages/win_tracer/win_tracer.dart';

import '/timer/intervalevent.dart';
import 'setting_pages/main_page.dart';
import 'setting_pages/setting_navigator.dart';
import './setting_pages/setting_sub_page.dart';

class SettingPage extends SettingNavigatorWidget {
  const SettingPage({
    Key? key,
    required onInitState,
    required config,
    required aliasDictionary,
  }) : super(key: key, onInitState: onInitState, config : config, aliasDictionary: aliasDictionary);

  @override
  State<SettingNavigatorWidget> createState() => SettingPageState();
}

class SettingPageState extends SettingNavigatorWidgetState {
  final titleSize = 32.0;
  final _titleNames = <String>[];
  NavigatorState? navigatorState;
  var _titles = <Widget>[];

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
  push<T extends Object?>(BuildContext context, SettingSubPage widget) {
    navigatorState = Navigator.of(context);
    widget.setEventPop(() {
      navigatorState?.pop();
      _titles.removeLast();
      refreshTitles();
    });

    navigatorState?.push(
      FluentPageRoute(builder: (context) => widget as Widget)
    );

    _titles.add( getTitleWidget(widget.title, context: context) );
    refreshTitles();
  }

  @override
  void pop<T>(BuildContext context) {
    if (navigatorState?.canPop() ?? false) {
      navigatorState?.pop();
    }
    _titles.removeLast();
    refreshTitles();
  }

  @override
  void initState() {
    super.initState();

    _titles.add( getTitleWidget("설정", context: context) );
  }

  refreshTitles() {
    //print("Refresh: ${[..._titles]}");
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
              child: MainPage(
                config : widget.config,
                onInitState: widget.onInitState,
                aliasDictionary: widget.aliasDictionary,
              )
            )
          )
        ],
      );
  }

  onEnable() {
    print("setting enable");
  }

  onDisable() {
    print("setting disable");
  }
}










