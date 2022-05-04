import 'model/order_history_model.dart';

List<OrderHistoryModel> orderHistoryMockData = [
  OrderHistoryModel(
      type: EOrderHistoryType.completed,
      orderId: '#03294234231',
      totalCount: 190,
      pickId: '9292120',
      pickedDate: '10/02/2022 - 12:03',
      totalPickTime: '10’12s',
      isOverTime: false),
  OrderHistoryModel(
      type: EOrderHistoryType.cancelled,
      orderId: '#03294234233',
      totalCount: 190,
      pickId: '9292111',
      pickedDate: '10/02/2022 - 10:03',
      totalPickTime: '10’12s',
      isOverTime: false),
  OrderHistoryModel(
      type: EOrderHistoryType.completed,
      orderId: '#03294234233',
      totalCount: 11,
      pickId: '9292123',
      pickedDate: '10/02/2022 - 15:03',
      totalPickTime: '60’12s',
      isOverTime: true),
  OrderHistoryModel(
      type: EOrderHistoryType.completed,
      orderId: '#03294234237',
      totalCount: 11,
      pickId: '9292127',
      pickedDate: '10/02/2022 - 16:03',
      totalPickTime: '50’54s',
      isOverTime: true),
  OrderHistoryModel(
      type: EOrderHistoryType.missed,
      orderId: '#03294234238',
      totalCount: 50,
      pickId: '9292128',
      pickedDate: '10/02/2022 - 11:11',
      totalPickTime: '10’12s',
      isOverTime: false),
  OrderHistoryModel(
      type: EOrderHistoryType.missed,
      orderId: '#03294234239',
      totalCount: 35,
      pickId: '9292129',
      pickedDate: '10/02/2022 - 12:12',
      totalPickTime: '10’12s',
      isOverTime: false),
  OrderHistoryModel(
      type: EOrderHistoryType.completed,
      orderId: '#03294234231',
      totalCount: 1,
      pickId: '9292120',
      pickedDate: '10/02/2022 - 12:03',
      totalPickTime: '10’12s',
      isOverTime: false),
  OrderHistoryModel(
      type: EOrderHistoryType.cancelled,
      orderId: '#03294234231',
      totalCount: 78,
      pickId: '9292120',
      pickedDate: '10/02/2022 - 12:03',
      totalPickTime: '10’12s',
      isOverTime: false)
];
