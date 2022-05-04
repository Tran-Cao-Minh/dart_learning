import 'package:picker/common/utils/cast_type.dart';
import 'package:picker/common/utils/responsive_layout.dart';

extension NumExtension on num {
  num toPrecision(int precision) {
    return num.parse(toStringAsFixed(precision));
  }
}

extension SizeExtension on double {
  double toLineHeight(double fontSize) {
    final lineHeight = this / fontSize;
    return asT<double>(lineHeight.toPrecision(2)) ?? 1.0;
  }

  ///[ResponsiveLayout.setWidth]
  double get w => ResponsiveLayout().setWidth(this);

  ///[ResponsiveLayout.setHeight]
  double get h => ResponsiveLayout().setHeight(this);

  ///[ResponsiveLayout.setSp]
  double get sp => ResponsiveLayout().setSp(this);

  bool get isEmpty {
    return this == 0.0;
  }
}

extension IntExtension on int? {
  String toCountCharactersRemaining({
    required int? maxLength,
  }) =>
      '${this ?? 0}/${maxLength ?? 0}';

  String get prepareResendTime {
    final minutes = this! ~/ 60;
    final seconds = this! - minutes * 60;

    final minutesString = minutes;
    final secondsString = seconds.toString().padLeft(2, '0');

    if (minutes == 0) {
      return '${secondsString}s';
    }

    return '$minutesString:${secondsString}s';
  }
}
