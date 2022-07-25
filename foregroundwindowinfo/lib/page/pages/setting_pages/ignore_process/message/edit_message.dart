import 'package:fluent_ui/fluent_ui.dart';
import 'package:wininfo/message_dialog/text_field.dart';
import 'package:wininfo/message_dialog/reject_info.dart';
import '/fwiconfig/global_config.dart';
import 'reject_message.dart';

showEditMessage({
  required BuildContext context,
  required bool Function(String, RejectMessage) onSubmitted,
  String name = "",
  TextEditingController? controller,
}) {
  final globalText = GlobalText();

  const height = 100.0;
  var _height = 100.0;
  var _reject = RejectInfo();
  controller?.text = name;

  updateHeight(setState) {
    var h = height;
    h += _reject.enabled ? 14 : 0;

    setState(() {
      _height = h;
    });
  }

  return showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
            title: Text(globalText["SET_IGNORE_PROCESS"],
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            content : StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return SizedBox(
                  height: _height,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DialogTextField(
                          placeholder: globalText["PLACEHOLDER_PROCESS"],
                          onChanged: (text) {
                            name = text;
                          },
                          highlightColor: _reject.highlightColor,
                          controller: controller,
                          errorMessage: _reject.message,
                          textStyle: TextStyle(
                            color: Colors.red,
                            fontSize : _reject.enabled ? 14 : 0,
                          ),
                        ),
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
                              child :Text(globalText["BUTTON_APPLY"],
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                var _name = name;
                                var _rejectMessage = RejectMessage();
                                var _submitted = onSubmitted(name, _rejectMessage);

                                if (_submitted) {
                                  Navigator.of(context).pop();
                                } else if (_rejectMessage.changed) {
                                  var rejectInfo = _reject;

                                  _reject.enabled = false;
                                  _reject.message = "";
                                  _reject.highlightColor = Colors.blue;
                                  setState(() {
                                    rejectInfo.enabled = true;
                                    rejectInfo.message = _rejectMessage.message;
                                    rejectInfo.highlightColor = Colors.red;
                                  });
                                  updateHeight(setState);
                                }
                              },
                            ),
                          ],
                        )
                      ]
                  ),
                );
              },
            )
        );
      }
  );
}