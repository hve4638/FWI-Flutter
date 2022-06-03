import 'dart:io';
import 'package:path/path.dart' as path;
import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef WINFunc = Pointer<Utf16> Function(Int32);
typedef WIFunc = Pointer<Utf16> Function(int);

typedef WCreateNFunc = Int32 Function();
typedef WCreateFunc = int Function();

typedef WDestroyNFunc = Int32 Function(Int32);
typedef WDestroyFunc = int Function(int);

typedef WInfoNFunc = Pointer<Utf16> Function(Int32);
typedef WInfoFunc = Pointer<Utf16> Function(int);

typedef WHandleNFunc = Pointer<Void> Function(Int32);
typedef WHandleFunc = Pointer<Void> Function(int);


var libraryPath = path.join(
    Directory.current.path, 'windowinfo.dll');

final dylib = DynamicLibrary.open(libraryPath);

WIFunc wiInfo = dylib
    .lookup<NativeFunction<WINFunc>>('winfo_info')
    .asFunction();

WCreateFunc wiCreate = dylib
    .lookup<NativeFunction<WCreateNFunc>>('winfo_create')
    .asFunction();
WDestroyFunc wiDestroy = dylib
    .lookup<NativeFunction<WDestroyNFunc>>('winfo_destroy')
    .asFunction();
WInfoFunc wiTitle = dylib
    .lookup<NativeFunction<WInfoNFunc>>('winfo_title')
    .asFunction();
WInfoFunc wiName = dylib
    .lookup<NativeFunction<WInfoNFunc>>('winfo_name')
    .asFunction();
WInfoFunc wiPath = dylib
    .lookup<NativeFunction<WInfoNFunc>>('winfo_path')
    .asFunction();
WInfoFunc wiHandle = dylib
    .lookup<NativeFunction<WInfoNFunc>>('winfo_handle')
    .asFunction();
