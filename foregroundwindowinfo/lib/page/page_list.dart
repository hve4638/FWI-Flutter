import 'package:fluent_ui/fluent_ui.dart';
import 'pages/win_tracer/win_tracer.dart';
import 'pages/win_tracer/win_tracer_stful.dart';

class PageList {
  final List<WinTracerWidget> _widgets = [];
  final List<WinTracerState> _states = [];
  final List<NavigationPaneItem> _paneItems = [];

  add({
    required String title,
    required icon,
    required WinTracerWidget widget
  }) {
    _paneItems.add(PaneItem(
      icon: icon,
      title: Text(title),
    ));
    _widgets.add(widget);
  }

  paneItems() {
    return _paneItems;
  }

  widgets() {
    return _widgets;
  }

  states() {
    return _states;
  }
}