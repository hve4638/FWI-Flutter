import 'package:fluent_ui/fluent_ui.dart';

import 'package:wininfo/page/navigate_page/navigate_page.dart';
import 'package:wininfo/page/pages/win_tracer/win_tracer.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';

import './setting_sub_page.dart';

class SettingNavigatorWidget extends StatefulWidget implements WinTracerWidget {
  const SettingNavigatorWidget({
    Key? key,
    required this.onInitState,
    required this.config,
    required this.aliasDictionary,
  }) : super(key: key);
  final FwiConfig config;
  final Function onInitState;
  final AliasDictionary aliasDictionary;

  static SettingNavigatorWidgetState? of(BuildContext context) {
    return context.findAncestorStateOfType<SettingNavigatorWidgetState>();
  }

  static SettingNavigator navigator(BuildContext context) {
    var nav = SettingNavigatorWidget.of(context);

    return SettingNavigator(state: nav, context: context);
  }

  @override
  State<SettingNavigatorWidget> createState() => SettingNavigatorWidgetState();
}

class SettingNavigatorWidgetState extends State<SettingNavigatorWidget> implements WinTracer {
  @override
  onDisable() {}
  @override
  onEnable() {}

  push<T extends Object?>(BuildContext context, SettingSubPage widget) {
    Navigator.of(context).push(
      FluentPageRoute(builder: (context) => widget as Widget),
    );
  }

  void pop<T>(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SettingNavigator {
  final SettingNavigatorWidgetState? state;
  final BuildContext context;

  SettingNavigator({
    required this.state,
    required this.context,
  });

  push<T extends Object?>(SettingSubPage widget)  {
    state?.push(context, widget);
  }

  pop<T>() {
    state?.pop(context);
  }
}
