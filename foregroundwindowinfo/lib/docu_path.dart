import 'package:path_provider/path_provider.dart';

Future<String> getDocuPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}