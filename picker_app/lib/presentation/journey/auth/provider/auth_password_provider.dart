import 'package:flutter/foundation.dart';

class AuthPasswordProvider extends ChangeNotifier {
  bool _isPasswordInvalid = false;
  bool get isPasswordInvalid => _isPasswordInvalid;

  bool _isObscure = true;
  bool get isObscure => _isObscure;

  void toggleObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}
