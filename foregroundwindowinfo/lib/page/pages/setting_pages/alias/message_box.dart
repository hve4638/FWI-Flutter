import 'package:fluent_ui/fluent_ui.dart';

class ErrorMessage {
  String name = "";
  String alias = "";
}

showAliasEditBox({
  required BuildContext context,
  required bool Function(String, String, ErrorMessage) onSubmitted,
  String name = "",
  String alias = "",
  TextEditingController? nameController,
  TextEditingController? aliasController,
  bool nameReadonly=false,
}) {
  nameController?.text = name;
  aliasController?.text = alias;

  showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
            title: const Text("프로세스 추가",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            content : SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextBox(
                    controller: nameController,
                    placeholder: "프로세스 이름",
                    onChanged: (text) {
                      name = text;
                    },
                    readOnly: nameReadonly,
                  ),
                  TextBox(
                    controller: aliasController,
                    placeholder: "별명",
                      onChanged: (text) {
                        alias = text;
                      }
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
                          var _alias = alias;
                          var _errorMessage = ErrorMessage();

                          if (_name != "" && onSubmitted(name, alias, _errorMessage)) {
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

showCheckBox({
  required BuildContext context,
  required Function onSubmitted
}) {
  showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
            content : SizedBox(
              height: 70,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("정말 삭제하시겠습니까?",
                      style: TextStyle(
                        fontSize: 18,
                      )
                    ),
                    const SizedBox(height: 10),
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
                          child :const Text("삭제",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xF4FF3643),
                            ),
                          ),
                          onPressed: () {
                            onSubmitted();
                            Navigator.of(context).pop();
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