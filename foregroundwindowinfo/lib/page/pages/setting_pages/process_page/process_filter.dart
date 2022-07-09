import 'dart:collection';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/page/pages/setting_pages/process_page/process_widget.dart';

import 'search_enum.dart';

class ProcessFilter extends IterableMixin<Widget> implements Iterator<Widget> {
  final List<ProcessWidget> list;
  final String search;
  final SearchType type;
  final SearchMode searchMode;
  final bool matchCase;
  int index = 0;
  Widget? _current;

  ProcessFilter({
    required this.list,
    required this.search,
    required this.type,
    this.matchCase = false,
    this.searchMode = SearchMode.plain,
  }) {
    index = 0;
  }

  @override
  Iterator<Widget> get iterator => this;

  @override
  moveNext() {
    var length = list.length;
    var pattern = _tryGetPattern();

    if (pattern == null) {
      while (index < length) {
        _current = list[index++];

        return true;
      }
    } else {
      while (index < length) {
        var pWidget = list[index++];
        var text = _getText(pWidget);

        if (text.contains(pattern)) {
          _current = pWidget;
          return true;
        }
      }
    }

    return false;
  }

  _tryGetPattern() {
    var text = search;
    if (!matchCase) text = text.toLowerCase();

    switch(searchMode) {
      case SearchMode.plain:
        return text;
      case SearchMode.regex:
        RegExp? pattern;
        try {
          pattern = RegExp(text);
        } on FormatException {
          print("FormatException: $text");
          pattern = null;
        }

        return pattern;
      default:
        return null;
    }
  }

  String _getText(ProcessWidget processWidget) {
    var text = "";
    switch(type) {
      case SearchType.name:
        text = processWidget.name;
        break;
      case SearchType.alias:
        text = processWidget.alias;
        break;
    }
    if (!matchCase) text = text.toLowerCase();

    return text;
  }

  @override
  get current => _current!;
}