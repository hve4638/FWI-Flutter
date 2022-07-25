import 'package:fluent_ui/fluent_ui.dart';

import '/fwiconfig/global_config.dart';

showDeleteMessage({
  required BuildContext context,
  required bool Function() onSubmitted
}) {
  var globalText = GlobalText();

  showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
            content : SizedBox(
              height: 70,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(globalText["MESSAGE_DELETE"],
                        style: TextStyle(
                          fontSize: 18,
                        )
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child : Text(globalText["BUTTON_CANCEL"],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child : Text(globalText["BUTTON_DELETE"],
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