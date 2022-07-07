import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/fwiconfig/fwi_config_readonly.dart';
import 'package:wininfo/fwiconfig/ignore_process_set.dart';
import 'package:wininfo/fwiconfig/alias_dic.dart';

class ConfigContainer extends StatefulWidget {
  ConfigContainer({
    Key? key,
    required this.child,
    required ignoreProcesses,
    required AliasDictionary aliases,
    required config,
  }) : super(key: key) {
    _config = config;
    _ignoreProcesses = ignoreProcesses;
    _aliases = aliases;
    _noAliases = aliases.noAlias;
  }
  final Widget child;
  IgnoreProcessSet? _ignoreProcesses;

  AliasDictionary? _aliases;
  NoAliasDictionary? _noAliases;
  FwiConfigReadonly? _config;

  static ConfigContainerState? of(BuildContext context) =>
      context.findAncestorStateOfType<ConfigContainerState>();

  static FwiConfigReadonly? config(BuildContext context) {
    return ConfigContainer.of(context)?.config;
  }

  static IgnoreProcessSet? ignoreProcesses(BuildContext context) {
    return ConfigContainer.of(context)?.ignoreProcesses;
  }

  static NoAliasDictionary? noAliases(BuildContext context) {
    return ConfigContainer.of(context)?.noAliases;
  }

  @override
  State<ConfigContainer> createState() => ConfigContainerState();
}

class ConfigContainerState extends State<ConfigContainer> {
  FwiConfigReadonly get config => widget._config!;
  IgnoreProcessSet get ignoreProcesses => widget._ignoreProcesses!;
  AliasDictionary get aliases => widget._aliases!;
  NoAliasDictionary get noAliases => widget._noAliases!;

  get text => "ConfigContainer111";

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
