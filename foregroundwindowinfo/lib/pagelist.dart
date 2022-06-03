import 'package:fluent_ui/fluent_ui.dart';
import 'page/wintracerstate.dart';

class PageList {
  final List<WinTracerWidget> _widgets = [];
  final List<WinTracerState> _states = [];
  final List<NavigationPaneItem> _paneitems = [];

  add({
    required String title,
    required icon,
    required WinTracerWidget widget
  }) {
    _paneitems.add(PaneItem(
      icon: icon,
      title: Text(title),
    ));
    _widgets.add(widget);
  }

  paneitems() {
    return _paneitems;
  }

  widgets() {
    return _widgets;
  }

  states() {
    return _states;
  }
}