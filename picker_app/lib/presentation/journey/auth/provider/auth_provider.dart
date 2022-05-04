import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  bool _isPhoneInvalid = false;
  bool get isPhoneInvalid => _isPhoneInvalid;

  void postAuth() {}

  void checkValidPhoneNumber(String phone) {
    final result = _isValidPhoneNumber(phone);

    _isPhoneInvalid = result == false && phone.length >= 10;
    notifyListeners();
  }

  bool _isValidPhoneNumber(String string) {
    // Null or empty string is invalid phone number
    if (string == null || string.isEmpty) {
      return false;
    }

    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v
    const pattern =
        r'(03|05|07|08|09|01[2|6|8|9]|843|845|847|848|849|841[2|6|8|9]])+([0-9]{8})\b';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }
}
