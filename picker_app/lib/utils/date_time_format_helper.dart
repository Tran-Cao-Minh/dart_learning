import 'package:intl/intl.dart';

class DateTimeFormatConstant {
  static const String DD_MM = 'dd/MM';
  static const String MM_YYYY = 'MM/yyyy';
  static const String DD_MM_YYYY = 'dd/MM/yyyy';
  static const String DD_MMMM_YYYY = 'dd/MMMM/yyyy';
  static const String HH_MM_A = 'hh:mm a';
  static const String HH_MM_24 = 'HH:mm';
  static const String DD_MM_YYYY_HH_MM_24 = 'dd/MM/yyyy HH:mm';
  static const String ISO = "yyyy-MM-dd'T'HH:mm:ss";
  static const String DATE_TIME_WITH_TIMEZONE_ISO_FORMAT =
      "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ";
  static const String DATE_TIME_WITH_TIMEZONE_FORMAT =
      "yyyy-MM-dd'T'HH:mm:ssZZ";
}

class DateTimeFormatHelper {
  DateTimeFormatHelper._internal();

  static final DateTimeFormatHelper _instance =
      DateTimeFormatHelper._internal();

  static DateTimeFormatHelper get shared => _instance;

  String format(String newPattern, DateTime dateTime) {
    return DateFormat(newPattern).format(dateTime);
  }

  DateTime? parseString2Date(String? date, {bool isUtc = false}) {
    if (date == null) {
      return null;
    }
    var newDate = date;
    if (isUtc == true) {
      if (!date.endsWith('Z')) {
        newDate = '${newDate}Z';
      }
    }
    final dateParsed = DateTime.tryParse(newDate);
    return isUtc == true ? dateParsed?.toUtc() : dateParsed;
  }
}
