import 'package:fluent_ui/fluent_ui.dart';
import './process_widget.dart';

abstract class ProcessListManager {
  resetProcessList();
  resetNoAliasList();
  update({ bool save });

  setOnChanged(Function(List<ProcessWidget>, List<ProcessWidget>) onChanged);
}