import 'package:test/test.dart';

void main() {
  print("a");
  var val = getAsyncResult(getString);

//  print(">>> $val");
}

getAsyncResult(call) {
  print("?>>>");
  var isComplete = false;
  var isError = false;
  dynamic value;

  call()
      .then((val) { isComplete = true; value = val;})
      .catchError((_) { isError = true; });

  while(!isComplete && !isError) {
    print("$isComplete $isError");
  }

  return value;
}

Future<String> getString() async {
  return "abc";
}
