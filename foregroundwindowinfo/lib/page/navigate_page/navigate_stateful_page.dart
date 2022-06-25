import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/page/pages/win_tracer/win_tracer.dart';

class NavigatePage extends StatefulWidget {
  const NavigatePage({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<NavigatePage> createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  NavigatorState? navigator;

  @optionalTypeArgs
  Future<T?> push<T extends Object?>(BuildContext context, Route<T> route) {
    return navigator!.push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings routeSettings) {
        return FluentPageRoute(builder: (context) {
          return widget.child;
        });
      },
    );
  }
}
