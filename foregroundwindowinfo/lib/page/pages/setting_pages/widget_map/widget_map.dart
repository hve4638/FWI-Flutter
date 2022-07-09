import 'package:fluent_ui/fluent_ui.dart';

class WidgetMap<T extends Widget> {
  final Map<String, T> map = {};

  operator []=(String key, T value) {
    add(key, value);
  }

  operator [](String key) {
    return map[key];
  }

  add(String name, T widget) {
    map[name] = widget;
  }

  remove(String name) {
    map.remove(name);
  }

  clear() {
    map.clear();
  }

  List<T> get widgets {
    var keys = map.keys.toList();
    keys.sort();

    var ls = <T>[];
    for(var key in keys) {
      ls.add(map[key]!);
    }

    return ls;
  }
}
