import 'package:fluent_ui/fluent_ui.dart';

showDeleteMessage({
  required BuildContext context,
  required bool Function() onSubmitted
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