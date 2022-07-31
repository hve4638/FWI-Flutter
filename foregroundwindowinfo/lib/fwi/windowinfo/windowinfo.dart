import '../../exceptions/exception_handler.dart';
import 'wi.dart';
import 'package:ffi/ffi.dart';

/*
* Flutter앱이 최상단이면서 사이즈를 조정중일때 title을 불러오면 간헐적으로 멈추는 버그존재
* WindowInfoLazy로 flutter 앱인지 확인후 title을 나중에 불러와야한다
* */
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