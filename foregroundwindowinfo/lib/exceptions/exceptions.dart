class CallWhenNotRunningException implements Exception {
  String cause;
  CallWhenNotRunningException([this.cause = ""]);
}
