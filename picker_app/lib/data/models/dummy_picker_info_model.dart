class DummyPickerInfoModel {
  String name;
  bool isActive;
  int totalOrder;
  int completedOrderCount;
  int missedOrderCount;
  int canceledOrderCount;
  double orderProductivityPercent;
  double timePerOrder;
  double timePerItem;
  double timeProductivityPercent;

  DummyPickerInfoModel({
    required this.name,
    required this.isActive,
    required this.totalOrder,
    required this.completedOrderCount,
    required this.missedOrderCount,
    required this.canceledOrderCount,
    required this.orderProductivityPercent,
    required this.timePerOrder,
    required this.timePerItem,
    required this.timeProductivityPercent,
  });
}
