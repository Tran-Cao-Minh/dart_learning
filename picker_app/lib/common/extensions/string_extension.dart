import 'package:picker/common/constants/constants.dart';

extension StringExtension on String {
  String uriPath() {
    final uri = Uri.tryParse(this);
    return uri!.path;
  }

  String get toAddPrefixPhoneNumber {
    if (isEmpty) {
      return '';
    }

    final isSame =
        RegExp(RegexConstant.phoneNumberCountryCodeRegex).hasMatch(trim());

    return isSame
        ? replaceAll(RegExp(RegexConstant.phoneNumberCountryCodeRegex), '0')
        : '0$this';
  }

  String toInsertDoubleSpaceToPhoneNumber({
    required int firstIndex,
    required int secondIndex,
  }) {
    final newLength = length;
    final stringBuffer = StringBuffer();
    var usedSubstringIndex = 0;

    if (newLength >= firstIndex) {
      usedSubstringIndex = firstIndex - 1;
      stringBuffer.write('${substring(0, usedSubstringIndex)} ');
    }

    if (newLength >= secondIndex) {
      usedSubstringIndex = secondIndex - 1;
      final startIndex = firstIndex - 1;
      stringBuffer.write('${substring(startIndex, usedSubstringIndex)} ');
    }

    /// add the rest to new string
    if (newLength >= usedSubstringIndex) {
      stringBuffer.write(substring(usedSubstringIndex));
    }

    return stringBuffer.toString();
  }

  String get toFormatterPhoneInput {
    return toAddPrefixPhoneNumber.toInsertDoubleSpaceToPhoneNumber(
      firstIndex: 5,
      secondIndex: 8,
    );
  }

  String toMapQueryToTextTag({
    required String textQuery,
    required String startTag,
    required String endTag,
  }) {
    try {
      for (var i = 0; i < length; i++) {
        if (this[i].toLowerCase() == textQuery[0].toLowerCase()) {
          if (i + textQuery.length <= length) {
            final temp = substring(i, i + textQuery.length);
            if (temp.toLowerCase() == textQuery.toLowerCase()) {
              return replaceAll(temp, '$startTag$temp$endTag');
            }
          }
        }
      }
      return this;
    } catch (e) {
      return this;
    }
  }
}

extension StringValidatorExtension on String? {
  bool get isNotNullAndEmpty => this != null && this!.isNotEmpty;

  bool get isNullOrEmpty => (this ?? '').isEmpty;

  bool isURL() =>
      RegExp(RegexConstant.validUrlRegex, caseSensitive: false).hasMatch(this!);

  bool get isValidPhoneNumber {
    if (isNullOrEmpty) {
      return false;
    }

    return RegExp(RegexConstant.validPhoneNumberRegex)
        .hasMatch(this!.trim().replaceAll(RegexConstant.hasSpaceCharacter, ''));
  }

  bool get isValidPasswordLength => this!.trim().length >= 8;

  bool get isValidCharacterPassword =>
      RegExp(RegexConstant.hasOnlyAlphabetsAndNumbersRegex)
          .hasMatch(this!.trim());

  bool isSamePassword(String value) => this!.trim() == value.trim();
}
