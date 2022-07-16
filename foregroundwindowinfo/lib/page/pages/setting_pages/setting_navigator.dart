import 'package:fluent_ui/fluent_ui.dart';
import './setting_sub_page.dart';

class SettingNavigatorWidget extends StatefulWidget {
  const SettingNavigatorWidget({
    Key? key,
  }) : super(key: key);

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

class SettingNavigatorWidgetState<T extends SettingNavigatorWidget> extends State<T> {
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
