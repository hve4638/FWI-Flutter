import 'package:fluent_ui/fluent_ui.dart';

import 'package:wininfo/message_dialog/text_field.dart';

import '../../../../../fwiconfig/global_config.dart';
import './reject_info.dart';
import './alert_message.dart';

showEditMessage({
  required BuildContext context,
  required bool Function(String, String, RejectMessage) onSubmitted,
  String name = "",
  String alias = "",
  TextEditingController? nameController,
  TextEditingController? aliasController,
  bool nameReadonly = false,
}) {
  var globalText = GlobalText();
  const Height = 120.0;

  nameController?.text = name;
  aliasController?.text = alias;
  var _nameReject = RejectInfo();
  var _aliasReject = RejectInfo();
  double _height = Height;
  var lockColor = const Color(0xffcbcbcb);

  RejectInfo getRejectInfo(RejectPosition position) {
    switch(position) {
      case RejectPosition.name:
        return _nameReject;
      case RejectPosition.alias:
        return _aliasReject;
      default:
        throw Error();
    }
  }

  clearRejectMessage(void Function(void Function()) setState) {
    for(var position in [RejectPosition.name, RejectPosition.alias]) {
      var rejectInfo = getRejectInfo(position);

      setState(() {
        rejectInfo.enabled = false;
        rejectInfo.message = "";
        rejectInfo.highlightColor = Colors.blue;
      });
    }

    if (nameReadonly) _nameReject.highlightColor = lockColor;
  }

  updateHeight(void Function(void Function()) setState) {
    double height = Height;
    height += _nameReject.enabled ? 14 : 0;
    height += _aliasReject.enabled ? 14 : 0;

    setState(() {
      _height = height;
    });
  }

  if (nameReadonly) _nameReject.highlightColor = lockColor;

  showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
            title: Text(globalText["SET_ALIAS"],
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
                          highlightColor: _nameReject.highlightColor,
                          readOnly: nameReadonly,
                          controller: nameController,
                          errorMessage: _nameReject.message,
                          textStyle: TextStyle(
                            color: Colors.red,
                            fontSize : _nameReject.enabled ? 14 : 0,
                          ),
                        ),
                        DialogTextField(
                          placeholder: globalText["PLACEHOLDER_ALIAS"],
                          onChanged: (text) {
                            alias = text;
                          },
                          highlightColor: _aliasReject.highlightColor,
                          controller: aliasController,
                          errorMessage: _aliasReject.message,
                          textStyle: TextStyle(
                            color: Colors.red,
                            fontSize : _aliasReject.enabled ? 14 : 0,
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
                              child : Text(globalText["BUTTON_APPLY"],
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                var _name = name;
                                var _alias = alias;
                                var _rejectMessage = RejectMessage();
                                var _submitted = onSubmitted(name, alias, _rejectMessage);

                                clearRejectMessage(setState);
                                if (_submitted) {
                                  Navigator.of(context).pop();
                                } else if (_rejectMessage.changed) {
                                  var rejectInfo = getRejectInfo(_rejectMessage.position);

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