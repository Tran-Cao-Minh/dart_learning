import 'package:flutter/foundation.dart';

class ConfirmCancelOrderProvider extends ChangeNotifier {
  final List<String> _reasonList = [
    'Thiếu đồ',
    'Khó lấy đồ',
    'Đồ bị hỏng ít',
    'Không tìm thấy hàng',
    'Đồ hết hạn',
    'Đồ bị hỏng nhiều',
    'Lý do khác'
  ];
  List<String> get reasonList => _reasonList;

  String? _valueSelected;
  String? get valueSelected => _valueSelected;

  String? _otherReason;
  String? get otherReason => _otherReason;

  void setReasonSelected(String reason) {
    _valueSelected = reason;
    notifyListeners();
  }

  void updateOtherReason(String reason) {
    _otherReason = reason;
    notifyListeners();
  }

  bool isShowOtherReasonInput() => _valueSelected == _reasonList.last;

  bool isEnableCancelButton() {
    if (isShowOtherReasonInput()) {
      return _valueSelected != null &&
          _valueSelected!.isNotEmpty &&
          _otherReason != null &&
          _otherReason!.isNotEmpty;
    }
    return _valueSelected != null && _valueSelected!.isNotEmpty;
  }
}
