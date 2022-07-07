class AliasInfo {
  final Map<String, String> map = {};
  String get name => map["name"]!;
  String get alias => map["alias"]!;

  AliasInfo(String name, String alias) {
    map["name"] = name;
    map["alias"] = alias;
  }

  set name(String name) {
    map["name"] = name;
  }

  set alias(String alias) {
    map["alias"] = alias;
  }
}