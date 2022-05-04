class RegexConstant {
  static const String hasDigitRegex = r'[0-9]';

  static const String hasLowerCaseRegex = r'[a-z]';

  static const String hasUpperCaseRegex = r'[A-Z]';

  static const String alphabetRegex = r'[a-zA-Z]';

  static const String hasOnlyDigitRegex = r'^[0-9]*$';

  static const String hasSpaceCharacter = r' ';

  static const String validImagePathRegex = r'\.(jpg|jpeg|png)$';

  static const String phoneNumberCountryCodeRegex = r'^(0|84|\+84)';

  static const String hasOnlyAlphabetsAndNumbersRegex = '[a-zA-Z0-9]';

  static const String validUrlRegex =
      r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';

  static const validPhoneNumberRegex =
      r'(03|05|07|08|09|01[2|6|8|9]|843|845|847|848|849|841[2|6|8|9]])+([0-9]{8})\b';
}
