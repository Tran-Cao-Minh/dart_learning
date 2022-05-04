import 'package:flutter/material.dart';

class ResponsiveLayout {
  static ResponsiveLayout? _instance;
  static const Size defaultSize = Size(375, 812);

  /// Size of the phone in UI Design , px
  Size uiSize = defaultSize;

  late BuildContext rootContext;

  /// allowFontScaling Specifies whether fonts should scale to respect
  /// Text Size accessibility settings. The default is false.
  bool allowFontScaling = false;

  static late double _pixelRatio;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _statusBarHeight;
  static late double _bottomBarHeight;
  static late double _textScaleFactor;

  factory ResponsiveLayout() {
    assert(
    _instance != null,
    '\nEnsure to initialize ResLayout before '
        'accessing it');

    return _instance!;
  }

  ResponsiveLayout._();

  static void init(
      BuildContext context, {
        Size designSize = defaultSize,
        bool allowFontScaling = false,
      }) {
    _instance ??= ResponsiveLayout._();
    _instance?.uiSize = designSize;
    _instance?.allowFontScaling = allowFontScaling;
    _instance?.rootContext = context;
    final mediaQuery = MediaQuery.of(context);
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  /// The number of font pixels for each logical pixel.
  double get textScaleFactor => _textScaleFactor;

  /// The size of the media in logical pixels (e.g, the size of the screen).
  double get pixelRatio => _pixelRatio;

  /// The horizontal extent of this size.
  double get screenWidth => _screenWidth;

  ///The vertical extent of this size. dp
  double get screenHeight => _screenHeight;

  /// The vertical extent of this size. px
  double get screenWidthPx => _screenWidth * _pixelRatio;

  /// The vertical extent of this size. px
  double get screenHeightPx => _screenHeight * _pixelRatio;

  /// The offset from the top
  double get statusBarHeight => _statusBarHeight;

  /// The offset from the bottom.
  double get bottomBarHeight => _bottomBarHeight;

  /// The ratio of the actual dp to the design draft px
  double get scaleWidth => _screenWidth / uiSize.width;

  double get scaleHeight =>
      (_screenHeight - _statusBarHeight - _bottomBarHeight) / uiSize.height;

  double get scaleText => scaleWidth;

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  double setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high
  /// degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a
  /// difference in shape.
  double setHeight(num height) => height * scaleHeight;

  double setSp(
      num fontSize, {
        bool? allowFontScalingSelf,
      }) =>
      (allowFontScaling || (allowFontScalingSelf ?? false))
          ? (fontSize * scaleText)
          : (fontSize * scaleText) / _textScaleFactor;
}
