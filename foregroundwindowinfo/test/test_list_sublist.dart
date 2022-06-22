import 'package:test/test.dart';

void main() {
  test('tesExpectList', testExpectList);
  test('tesExpectList', testSubList);
}

testExpectList() {
  expect([1, 2, 3], [1, 2, 3]);
}

testSubList() {
  var _list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  //expect([0, 1, 2], _list.sublist(0, 3));
  expect([8, 9], _list.sublist(8, 10));
}