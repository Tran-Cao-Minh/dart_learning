import 'package:flutter/foundation.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  bool _isPasswordInvalid = false;
  bool get isPasswordInvalid => _isPasswordInvalid;
}
