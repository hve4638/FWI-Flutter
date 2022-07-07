import 'package:test/test.dart';

void main() {
  var set = <String>{ "apple", "chicken", "banana" };

  var ls = set.toList();
  ls.sort();

  for(var key in ls) {
    print(key);
  }
}