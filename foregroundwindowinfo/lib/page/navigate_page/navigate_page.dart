import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/page/pages/win_tracer/win_tracer.dart';

class NavigatePage extends StatelessWidget implements WinTracerWidget {
  const NavigatePage({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings routeSettings) {
        return FluentPageRoute(builder: (context) {
          return child;
        });
      },
    );
  }
}