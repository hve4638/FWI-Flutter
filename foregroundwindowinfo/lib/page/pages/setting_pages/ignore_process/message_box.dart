import 'package:fluent_ui/fluent_ui.dart';

showEditMessage({
  String title = "프로세스 추가",
  required BuildContext context,
  required String name,
  required Function(String) onSubmitted,
  TextEditingController? controller,
}) {
  controller?.text = name;

  showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
            title: Text(title,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            content : SizedBox(
              height: 80,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextBox(
                      controller: controller,
                      placeholder: "프로세스 이름",
                      onChanged: (text) {
                        name = text;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child : const Text("취소",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child :const Text("확인",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            var _name = name;
                            if (_name != "") {
                              onSubmitted(_name);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    )
                  ]
              ),
            )
        );
      }
  );
}