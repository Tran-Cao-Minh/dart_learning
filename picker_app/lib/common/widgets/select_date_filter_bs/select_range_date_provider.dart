import 'package:flutter/cupertino.dart';
import 'package:picker/utils/date_time_format_helper.dart';
import 'package:picker/utils/date_time_helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:picker/common/common.dart';

import 'select_range_date_filter_bs.dart';

class SelectRangeDateProvider extends ChangeNotifier {
  final DateRangePickerController controller = DateRangePickerController();

  EReportPeriodType get quickFilterSelected => _quickFilterSelected;
  EReportPeriodType _quickFilterSelected = EReportPeriodType.today;

  final List<EReportPeriodType> _quickSelectRangeDateList = [
    EReportPeriodType.today,
    EReportPeriodType.thisWeek,
    EReportPeriodType.thisMonth,
    EReportPeriodType.lastWeek,
    EReportPeriodType.lastMonth
  ];
  List<EReportPeriodType> get quickSelectRangeDateList =>
      _quickSelectRangeDateList;

  late DateRange _dateRange;
  DateRange get dateRangeSelected => _dateRange;

  String get dateRangeTitle => _getDateRangeTitle();

  SelectRangeDateProvider() {
    _quickFilterSelected = EReportPeriodType.today;
    _dateRange = _calculateDateRangeByType(_quickFilterSelected);
  }

  void setQuickFilterSelected(EReportPeriodType type) {
    _quickFilterSelected = type;
    _dateRange = _calculateDateRangeByType(type);
    debugPrint(_dateRange.toString());
    notifyListeners();
  }

  void setDateRangeSelected(DateTime startDate, DateTime endDate) {
    _dateRange = DateRange(startDate: startDate, endDate: endDate);
    debugPrint(_dateRange.toString());
    notifyListeners();
  }

  DateRange _calculateDateRangeByType(EReportPeriodType type) {
    return DateTimeHelper.getDateRangeByPeriod(DateTime.now(), type);
  }

  String _getDateRangeTitle() {
    final startDateCopy = _dateRange.startDate.copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    final endDateCopy = _dateRange.endDate.copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

    if (startDateCopy.isAtSameMomentAs(endDateCopy)) {
      return DateTimeFormatHelper.shared
          .format(DateTimeFormatConstant.DD_MM_YYYY, _dateRange.startDate);
    }
    final start = DateTimeFormatHelper.shared
        .format(DateTimeFormatConstant.DD_MM, _dateRange.startDate);
    final end = DateTimeFormatHelper.shared
        .format(DateTimeFormatConstant.DD_MM, _dateRange.endDate);
    return '$start - $end';
  }
}
