import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'select_range_date_provider.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/date_time_helper.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';

export 'select_range_date_provider.dart';

class DateRange {
  final DateTime startDate;
  final DateTime endDate;

  DateRange({
    required this.startDate,
    required this.endDate,
  });

  PickerDateRange toPickerDateRange() => PickerDateRange(startDate, endDate);

  @override
  String toString() => 'DateRange(startDate: $startDate, endDate: $endDate)';
}

Future<DateRange?> showSelectRangeDateFilterBottomSheet(
    BuildContext context) async {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (context) => const FractionallySizedBox(
            heightFactor: 0.95,
            child: OrderDateFilterBottomSheet(),
          ));
}

class OrderDateFilterBottomSheet extends StatelessWidget {
  final EReportPeriodType initQuickFilterType;
  final DateRange? dateRange;

  const OrderDateFilterBottomSheet({
    Key? key,
    this.initQuickFilterType = EReportPeriodType.today,
    this.dateRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectRangeDateProvider(),
      builder: (context, child) => Column(
        children: [
          _ToolbarBS(),
          _QuickSelectionView(),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: normalize(12)),
            child: _DateView(),
          ))
        ],
      ),
    );
  }
}

class _ToolbarBS extends StatelessWidget {
  const _ToolbarBS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: normalize(35),
            height: normalize(2),
            margin: EdgeInsets.only(top: normalize(7), bottom: normalize(14)),
            decoration: BoxDecoration(
                color: greyC4,
                borderRadius: BorderRadius.circular(normalize(20))),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: normalize(8)),
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyleCommon.displaySubBody(context,
                          color: grey66),
                    )),
                Expanded(
                    child: Consumer<SelectRangeDateProvider>(
                  builder: (context, value, child) => Text(
                    value.dateRangeTitle,
                    textAlign: TextAlign.center,
                    style: TextStyleCommon.displayHeader(context),
                  ),
                )),
                TextButton(
                    onPressed: () {
                      final result = context
                          .read<SelectRangeDateProvider>()
                          .dateRangeSelected;
                      Navigator.of(context).pop(result);
                    },
                    child: Text(
                      'Update',
                      style: TextStyleCommon.displaySubBody(context,
                          color: grey66),
                    )),
              ],
            ),
          ),
          Divider(
            height: normalize(1),
            color: black.withOpacity(0.2),
          )
        ],
      ),
    );
  }
}

class _QuickSelectionView extends StatelessWidget {
  const _QuickSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: normalize(55),
            child: Consumer<SelectRangeDateProvider>(
              builder: (context, provider, child) => ListView.builder(
                  itemCount: provider.quickSelectRangeDateList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, pos) => _QuickSelectionItemView(
                        item: provider.quickSelectRangeDateList[pos],
                        isSelected: provider.quickSelectRangeDateList[pos] ==
                            provider.quickFilterSelected,
                      )),
            )),
        Divider(
          height: 1,
          color: black.withOpacity(0.2),
        )
      ],
    );
  }
}

class _QuickSelectionItemView extends StatelessWidget {
  final EReportPeriodType item;
  final bool isSelected;
  const _QuickSelectionItemView({
    Key? key,
    required this.item,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: normalize(6), vertical: normalize(8)),
      child: Material(
        color: isSelected ? fushiaC8A : greyF3,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          normalize(13),
        )),
        child: InkWell(
          onTap: () => context
              .read<SelectRangeDateProvider>()
              .setQuickFilterSelected(item),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                normalize(13),
              ),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: normalize(12), vertical: normalize(4)),
            child: Center(
              child: Text(
                item.title,
                style: TextStyleCommon.displaySubBody(context,
                    color: isSelected ? white : black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectRangeDateProvider>(
        builder: (context, provider, child) {
      final dateRange = provider.dateRangeSelected.toPickerDateRange();
      return SfDateRangePicker(
        key: UniqueKey(),
        initialDisplayDate: dateRange.startDate,
        initialSelectedRange: dateRange,
        toggleDaySelection: true,
        selectionMode: DateRangePickerSelectionMode.range,
        enableMultiView: true,
        navigationMode: DateRangePickerNavigationMode.scroll,
        allowViewNavigation: false,
        navigationDirection: DateRangePickerNavigationDirection.vertical,
        viewSpacing: 10,
        // monthFormat: 'MM',
        todayHighlightColor: fushiaC8A,
        selectionColor: black,
        headerStyle: DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: TextStyleCommon.displayHeaderBold(context,
                color: black, fontSize: 16)),
        monthCellStyle: DateRangePickerMonthCellStyle(
            todayTextStyle: TextStyleCommon.displayHeaderBold(context,
                color: fushiaC8A, fontSize: 14),
            textStyle: TextStyleCommon.displaySubBody(context, color: grey66)),
        rangeTextStyle: TextStyleCommon.displaySubBody(context, color: grey66),
        selectionTextStyle:
            TextStyleCommon.displaySubBody(context, color: white),
        monthViewSettings: DateRangePickerMonthViewSettings(
            dayFormat: 'E',
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: TextStyleCommon.displayHeaderBold(context,
                    color: black, fontSize: 16))),
        rangeSelectionColor: lilac.withOpacity(0.1),
        startRangeSelectionColor: fushiaC8A,
        endRangeSelectionColor: fushiaC8A,
        onViewChanged: (DateRangePickerViewChangedArgs args) {},
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
          if (args.value is PickerDateRange) {
            final DateTime rangeStartDate = args.value.startDate;
            final DateTime rangeEndDate = args.value.endDate ?? rangeStartDate;
            context
                .read<SelectRangeDateProvider>()
                .setDateRangeSelected(rangeStartDate, rangeEndDate);
          } else if (args.value is DateTime) {
            final DateTime selectedDate = args.value;
            context
                .read<SelectRangeDateProvider>()
                .setDateRangeSelected(selectedDate, selectedDate);
          }
        },
      );
    });
  }
}
