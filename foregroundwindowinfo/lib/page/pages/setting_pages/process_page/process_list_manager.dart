import 'package:fluent_ui/fluent_ui.dart';

abstract class ProcessListManager {
  setOnChanged(Function(List<Widget>, List<Widget>) onChanged);
}