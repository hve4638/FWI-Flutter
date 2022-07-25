import 'package:fluent_ui/fluent_ui.dart';

class TextEditingControllers {
  var controllers = <String, TextEditingController>{};

  operator[](String key) {
    if (!contains(key)) {
      controllers[key] = TextEditingController();
    }

    return controllers[key];
  }

  bool contains(String key) {
    return controllers.containsKey(key);
  }

  dispose() {
    controllers.forEach((key, controller) {
      controller.dispose();
    });

    controllers.clear();
  }
}