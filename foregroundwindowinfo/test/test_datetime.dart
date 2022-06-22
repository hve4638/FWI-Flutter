import 'package:test/test.dart';

void main() {
  var a = DateTime(2000,1,1,12,10,0);
  var b = DateTime(2000,1,1,12,25,0);
  var between = b.difference(a);

  print("###################");
  print(between.inHours);
  print(between.inMinutes);
  print(between.inSeconds);
  print("###################");
}