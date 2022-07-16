enum RejectPosition {
  name,
  alias,
  none
}

class RejectMessage {
  bool _changed = false;
  String _message = "";
  RejectPosition _position = RejectPosition.none;

  bool get changed => _changed;
  String get message => _message;
  RejectPosition get position => _position;

  set message(String text) {
    _message = text;
    _changed = true;
  }
  set position(RejectPosition position) {
    _position = position;
    _changed = true;
  }
}