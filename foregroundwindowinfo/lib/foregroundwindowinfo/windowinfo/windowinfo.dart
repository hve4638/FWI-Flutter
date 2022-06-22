import 'wi.dart';
import 'package:ffi/ffi.dart';

class WindowInfo {
  dynamic _pointer;
  String _name = "unknown";
  String _title = "unknown";
  String _path = "unknown";

  String get name => _name;
  String get title => _title;
  String get path => _path;
  get pointer => _pointer;

  WindowInfo() {
    var _id = wiCreate();

    _pointer = wiHandle(_id);
    _path = wiPath(_id).toDartString();
    _title = wiTitle(_id).toDartString();
    _name = wiName(_id).toDartString();

    wiDestroy(_id);
  }
}

class WindowInfoLazy {
  int _id = -1;
  dynamic _pointer;
  String ?_name;
  String ?_title;
  String ?_path;

  String get name {
    _name ??= wiName(_id).toDartString();
    return _name!;
  }
  String get title {
    _title = wiTitle(_id).toDartString();
    return _title!;
  }
  String get path {
    _path ??= wiPath(_id).toDartString();
    return _path!;
  }
  get pointer {
    _pointer ??= wiHandle(_id);
    return _pointer!;
  }

  WindowInfoLazy() {
    _id = wiCreate();
  }

  dispose() {
    wiDestroy(_id);
    _id = -1;
  }
}