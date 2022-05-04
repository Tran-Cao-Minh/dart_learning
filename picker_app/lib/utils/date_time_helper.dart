import 'package:dart_extensions/dart_extensions.dart';
import 'package:picker/common/common.dart';

enum EReportPeriodType {
  today,
  yesterday,
  thisWeek,
  lastWeek,
  fourLastWeek,
  thisMonth,
  lastMonth,
  thisYear,
  lastYear,
  threeLastYear,
  thisQuarter
}

extension EReportPeriodTypeExt on EReportPeriodType {
  String get title => _getTitle();
  String _getTitle() {
    switch (this) {
      case EReportPeriodType.today:
        return 'Hôm nay';
      case EReportPeriodType.thisWeek:
        return 'Tuần này';
      case EReportPeriodType.thisMonth:
        return 'Tháng này';
      case EReportPeriodType.lastWeek:
        return 'Tuần trước';
      case EReportPeriodType.lastMonth:
        return 'Tháng trước';
      default:
        return '';
    }
  }
}

class DateTimeHelper {
  ///
  /// Lấy khoảng thời gian của kỳ báo cáo
  ///
  static DateRange getDateRangeByPeriod(
      DateTime dateTime, EReportPeriodType period) {
    switch (period) {
      case EReportPeriodType.today:
        return getToday();
      case EReportPeriodType.yesterday:
        return getYesterday();
      case EReportPeriodType.thisWeek:
        return getWeekRange(ofDate: dateTime);
      case EReportPeriodType.lastWeek:
        return getLastWeekRange(ofDate: dateTime);
      case EReportPeriodType.fourLastWeek:
        return getFourLastWeekRange(ofDate: dateTime);
      case EReportPeriodType.thisMonth:
        return getMonthRange(ofDate: dateTime);
      case EReportPeriodType.lastMonth:
        return getLastMonthRange(ofDate: dateTime);
      case EReportPeriodType.thisYear:
        return getYearRange(ofDate: dateTime);
      case EReportPeriodType.lastYear:
        return getLastYearRange(ofDate: dateTime);
      case EReportPeriodType.threeLastYear:
        return getLastThreeYearRange(ofDate: dateTime);
      case EReportPeriodType.thisQuarter:
        return getQuarterRange(ofDate: dateTime);
      default:
        return getToday();
    }
  }

  /// Set thời gian của date time hiện tại về đầu ngày
  static DateTime getStartOfDate(DateTime dateTime) {
    final startOfDate = dateTime.copyWith(
        hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);
    return startOfDate;
  }

  /// Set thời gian của date time hiện tại về cuối ngày
  static DateTime getEndOfDate(DateTime dateTime) {
    final endOfDate = dateTime.copyWith(
        hour: 23, minute: 59, second: 59, microsecond: 0, millisecond: 0);
    return endOfDate;
  }

  /// Hôm nay
  static DateRange getToday() {
    final today = DateTime.now();
    return DateRange(
        startDate: getStartOfDate(today), endDate: getEndOfDate(today));
  }

  /// Ngày hôm trước
  static DateRange getYesterday({
    DateTime? ofDate,
  }) {
    final yesterday = ofDate?.yesterday() ?? DateTime.now().yesterday();
    return DateRange(
        startDate: getStartOfDate(yesterday), endDate: getEndOfDate(yesterday));
  }

  /// Ngày mai
  static DateRange getTomorrow() {
    final tomorrow = DateTime.now().tomorrow();
    return DateRange(
        startDate: getStartOfDate(tomorrow), endDate: getEndOfDate(tomorrow));
  }

  ///
  /// 7 ngày gần đây
  ///
  static DateRange getLastSevenDay() {
    final today = getToday();
    final lastSevenDay = today.startDate.addOrRemoveDay(-7);
    return DateRange(
        startDate: getStartOfDate(lastSevenDay),
        endDate: getEndOfDate(today.endDate));
  }

  ///
  /// 30 ngày gần đây
  ///
  static DateRange getLastThirtyDay() {
    final today = getToday();
    final lastSevenDay = today.startDate.addOrRemoveDay(-30);
    return DateRange(
        startDate: getStartOfDate(lastSevenDay),
        endDate: getEndOfDate(today.endDate));
  }

  /// Khoảng thời gian của tuần hiện tại
  static DateRange getWeekRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate ?? DateTime.now();
    final tempDate = dateTimeCheck.copyWith(
        year: dateTimeCheck.year,
        month: dateTimeCheck.month,
        day: dateTimeCheck.day,
        hour: dateTimeCheck.hour,
        minute: dateTimeCheck.minute,
        second: dateTimeCheck.second,
        microsecond: dateTimeCheck.microsecond,
        millisecond: dateTimeCheck.millisecond);

    final currentDayOfWeek = tempDate.weekday;
    final startWeek = tempDate.subtract(Duration(days: currentDayOfWeek - 1));

    final endWeek =
        tempDate.add(Duration(days: DateTime.daysPerWeek - tempDate.weekday));

    return DateRange(
        startDate: getStartOfDate(startWeek), endDate: getEndOfDate(endWeek));
  }

  /// Khoảng thời gian của tuần trước
  static DateRange getLastWeekRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate ?? DateTime.now();
    final currentWeek = getWeekRange(ofDate: dateTimeCheck);
    final firstCurrentWeek = currentWeek.startDate;

    // Trừ đi 1 ngày để về tuần trước => Chủ nhật
    final beforeWeek = firstCurrentWeek.subtract(const Duration(days: 1));

    final lastWeek = getWeekRange(ofDate: beforeWeek);

    return DateRange(
        startDate: getStartOfDate(lastWeek.startDate),
        endDate: getEndOfDate(lastWeek.endDate));
  }

  /// Khoảng thời gian của tuần kế tiếp
  static DateRange getNextWeekRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate ?? DateTime.now();
    final currentWeek = getWeekRange(ofDate: dateTimeCheck);

    final endOfCurrentWeek = currentWeek.endDate;

    // Cộng thêm 1 ngày để lên tuần kế tiếp => Thứ 2
    final startOfNextWeek = endOfCurrentWeek.add(const Duration(days: 1));
    final endOfNextWeek = startOfNextWeek
        .add(Duration(days: DateTime.daysPerWeek - startOfNextWeek.weekday));

    return DateRange(
        startDate: getStartOfDate(startOfNextWeek),
        endDate: getEndOfDate(endOfNextWeek));
  }

  /// Khoảng thời gian của 4 tuần trước
  static getFourLastWeekRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate ?? DateTime.now();
    final currentWeek = getWeekRange(ofDate: dateTimeCheck);

    /// 4 Tuần trước đó tính từ ngày [ofDate]
    /// Vì tính cả tuần hiện tại nên chỉ trừ đi 21 ngày (3 tuần)
    final fourLastWeek = currentWeek.startDate.addOrRemoveDay(-21);

    return DateRange(
        startDate: getStartOfDate(fourLastWeek),
        endDate: getEndOfDate(currentWeek.endDate));
  }

  /// Khoảng thời gian của tháng hiện tại
  static DateRange getMonthRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate ?? DateTime.now();
    return DateRange(
        startDate: getStartOfDate(dateTimeCheck.firstDayOfMonth),
        endDate: getEndOfDate(dateTimeCheck.lastDayOfMonth));
  }

  /// Khoảng thời gian của tháng trước, tính từ tháng hiện tại
  static DateRange getLastMonthRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate ?? DateTime.now();
    final firstDayOfMonth = dateTimeCheck.firstDayOfMonth;
    final lastDayOfLastMonth =
        firstDayOfMonth.subtract(const Duration(days: 1));
    final firstDayOfLastMonth = lastDayOfLastMonth.firstDayOfMonth;

    return DateRange(
        startDate: getStartOfDate(firstDayOfLastMonth),
        endDate: getEndOfDate(lastDayOfLastMonth));
  }

  /// Khoảng thời gian của 6 tháng trước, tính từ tháng hiện tại
  static getSixLastMonthRange(DateTime dateTime) {
    ///
  }

  /// Khoảng thời gian của tháng kế tiếp, tính từ tháng hiện tại
  static DateRange getNextMonthRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate ?? DateTime.now();
    final lastDayOfMonth = dateTimeCheck.lastDayOfMonth;
    final firstDayOfNextMonth = lastDayOfMonth.add(const Duration(days: 1));
    final lastDayOfNextMonth = firstDayOfNextMonth.lastDayOfMonth;

    return DateRange(
        startDate: getStartOfDate(firstDayOfNextMonth),
        endDate: getEndOfDate(lastDayOfNextMonth));
  }

  /// Khoảng thời gian của năm
  static DateRange getYearRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate ?? DateTime.now();
    final startOfYear = dateTimeCheck.startOfYear();
    final endOfYear = startOfYear.copyWith(month: DateTime.december, day: 31);

    return DateRange(
        startDate: getStartOfDate(startOfYear),
        endDate: getEndOfDate(endOfYear));
  }

  /// Khoảng thời gian của năm trước, tính từ năm hiện tại
  static DateRange getLastYearRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate ?? DateTime.now();
    final startOfYear = dateTimeCheck.startOfYear();
    final endOfLastYear = startOfYear.copyWith(
        year: startOfYear.year - 1, month: DateTime.december, day: 31);
    final startOfLastYear = endOfLastYear.startOfYear();

    return DateRange(
        startDate: getStartOfDate(startOfLastYear),
        endDate: getEndOfDate(endOfLastYear));
  }

  /// Khoảng thời gian của 3 năm gần đây
  static DateRange getLastThreeYearRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate?.copyWith() ?? DateTime.now();

    final DateTime lastThreeYear = dateTimeCheck.addOrRemoveYears(-3);
    return DateRange(
        startDate: getStartOfDate(lastThreeYear.startOfYear()),
        endDate: getEndOfDate(ofDate ?? DateTime.now()));
  }

  /// Khoảng thời gian của 1 quý
  static DateRange getQuarterRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate ?? DateTime.now();
    final firstDayOfMonth = dateTimeCheck.firstDayOfMonth;

    /// Tháng của thời gian hiện tại
    final monthOfYear = firstDayOfMonth.month;

    if (monthOfYear <= 3) {
      /// Quý 1
      final startQuarterDate = dateTimeCheck.copyWith(month: 1, day: 1);
      var endQuarterDate = dateTimeCheck.copyWith(month: 3);
      endQuarterDate =
          endQuarterDate.copyWith(day: endQuarterDate.lastDayOfMonth.day);

      return DateRange(startDate: startQuarterDate, endDate: endQuarterDate);
    } else if (monthOfYear <= 6) {
      /// Quý 2
      final startQuarterDate = dateTimeCheck.copyWith(month: 4, day: 1);
      var endQuarterDate = dateTimeCheck.copyWith(month: 6);
      endQuarterDate =
          endQuarterDate.copyWith(day: endQuarterDate.lastDayOfMonth.day);

      return DateRange(startDate: startQuarterDate, endDate: endQuarterDate);
    } else if (monthOfYear <= 9) {
      /// Quý 3
      final startQuarterDate = dateTimeCheck.copyWith(month: 7, day: 1);
      final endQuarterDate = dateTimeCheck.copyWith(month: 9);

      return DateRange(startDate: startQuarterDate, endDate: endQuarterDate);
    } else {
      /// Quý 4
      ///
      final startQuarterDate = dateTimeCheck.copyWith(month: 10, day: 1);
      final endQuarterDate = dateTimeCheck.copyWith(month: 12);

      return DateRange(
          startDate: getStartOfDate(startQuarterDate),
          endDate: getEndOfDate(endQuarterDate));
    }
  }

  /// Khoảng thời gian của 1 quý trước, tính từ quý hiện tại
  static DateRange getLastQuarterRange({
    DateTime? ofDate,
  }) {
    final dateTimeCheck = ofDate ?? DateTime.now();
    final currentQuarter = getQuarterRange(ofDate: dateTimeCheck);
    final startOfCurrentQuarter = currentQuarter.startDate;

    final lastDaysOfLastQuarter =
        startOfCurrentQuarter.subtract(const Duration(days: 1));

    return getQuarterRange(ofDate: lastDaysOfLastQuarter);
  }
}
