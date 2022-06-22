import 'package:fluent_ui/fluent_ui.dart';
import '../win_tracer/win_tracer_stful.dart';
import 'package:wininfo/fwiconfig/fwi_config.dart';
import './test_subpage.dart';
import './setting_widgets.dart';

class SubPage extends StatefulWidget {
  const SubPage({Key? key}) : super(key: key);

  @override
  State<SubPage> createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  @override
  Widget build(BuildContext context) {
    return SettingContainer("서브",
        body: Container(
            color: Colors.white,
            child: Center(
              child: Text("a"),
            )
        )
    );
  }

}


