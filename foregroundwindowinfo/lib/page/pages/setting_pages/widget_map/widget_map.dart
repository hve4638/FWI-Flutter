import 'package:fluent_ui/fluent_ui.dart';

class WidgetMap {
  final Map<String, Widget> map = {};

  operator []=(String key, Widget value) {
    add(key, value);
  }

  operator [](String key) {
    return map[key];
  }

  add(String name, Widget widget) {
    map[name] = widget;
  }

  remove(String name) {
    map.remove(name);
  }

  List<Widget> get widgets {
    var keys = map.keys.toList();
    keys.sort();

    var ls = <Widget>[];
    for(var key in keys) {
      ls.add(map[key]!);
    }

    return ls;
  }
}
