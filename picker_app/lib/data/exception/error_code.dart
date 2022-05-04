class ErrorCodes {
  static _Common get Common => _Common();
}

class _Common {
  static final _Common _singleton = _Common._internal();

  factory _Common() {
    return _singleton;
  }

  _Common._internal();

  final String paramInvalid = 'PARAM_INVALID';
}
