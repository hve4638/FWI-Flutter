import 'package:test/test.dart';
import "package:ini/ini.dart";

void main() {
  test('testHasSection', () {
    var config = Config();

    config.addSection("section1");

    expect(config.hasSection("section1"), true);
    expect(config.hasSection("section2"), false);
  });
  test('testHasOption', () {
    var config = Config();

    config.addSection("section1");
    config.set("section1", "option1", "abc");

    expect(config.hasOption("section1", "option1"), true);
    expect(config.hasOption("section1", "option2"), false);
  });
  test('testHasOptionWithoutSectionCheck', () {
    var config = Config();

    config.addSection("section1");
    config.set("section1", "option1", "abc");

    expect(config.hasOption("section2", "option1"), false);
  });
}