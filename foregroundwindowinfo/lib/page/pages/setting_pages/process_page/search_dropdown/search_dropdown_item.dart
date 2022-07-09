import 'package:fluent_ui/fluent_ui.dart';

class SearchDropDownItem<T> {
  final String title;
  final IconData icon;
  final T value;

  SearchDropDownItem({
    required this.title,
    required this.value,
    required this.icon,
  });
}