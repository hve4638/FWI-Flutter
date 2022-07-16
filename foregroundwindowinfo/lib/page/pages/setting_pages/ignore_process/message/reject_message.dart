class RejectMessage {
  bool _changed = false;
  String _message = "";

  bool get changed => _changed;
  String get message => _message;

  set message(String text) {
    _message = text;
    _changed = true;
  }
}