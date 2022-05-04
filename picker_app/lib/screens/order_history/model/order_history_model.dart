import 'package:flutter/material.dart';
import 'package:picker/utils/constants.dart';

enum EOrderHistoryType { completed, cancelled, missed }

extension EOrderHistoryTypeExt on EOrderHistoryType {
  String get resourceName => _getResourceName();
  String get status => _getTitle();

  String _getResourceName() {
    switch (this) {
      case EOrderHistoryType.completed:
        return 'assets/icons/ic_order_completed.svg';
      case EOrderHistoryType.cancelled:
        return 'assets/icons/ic_order_cancelled.svg';
      case EOrderHistoryType.missed:
        return 'assets/icons/ic_order_missed.svg';
      default:
        return 'assets/icons/ic_order_completed.svg';
    }
  }

  String _getTitle() {
    switch (this) {
      case EOrderHistoryType.completed:
        return 'Hoàn thành';
      case EOrderHistoryType.cancelled:
        return 'Đã huỷ';
      default:
        return '';
    }
  }
}

class OrderHistoryModel {
  final EOrderHistoryType type;
  final String orderId;
  final int totalCount;
  final String pickId;
  final String pickedDate;
  final String? totalPickTime;
  final bool isOverTime;

  OrderHistoryModel({
    required this.type,
    required this.orderId,
    required this.totalCount,
    required this.pickId,
    required this.pickedDate,
    this.totalPickTime,
    required this.isOverTime,
  });

  String getTotalPickedTime() {
    switch (type) {
      case EOrderHistoryType.completed:
      case EOrderHistoryType.cancelled:
        return totalPickTime ?? '--';
      default:
        return '--';
    }
  }

  Color getResourceColor() {
    switch (type) {
      case EOrderHistoryType.completed:
        return green41;
      case EOrderHistoryType.cancelled:
        return red;
      case EOrderHistoryType.missed:
        return red;
      default:
        return black;
    }
  }

  Color getPickedTimeColor() {
    if (isOverTime) {
      return yellow00;
    }
    switch (type) {
      case EOrderHistoryType.completed:
        return green41;
      default:
        return black;
    }
  }
}
