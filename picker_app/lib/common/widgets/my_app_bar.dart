import 'dart:io';

import 'package:flutter/services.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';

extension MyAppBarTheme on ThemeData {
  TextStyle get headerTitleTextStyle => primaryHeader.copyWith(
        fontSize: dimen_17.sp,
        height: dimen_20.sp.toLineHeight(dimen_17.sp),
      );
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? titleLabel;
  final Widget? trailing;
  final Color? bgColor;
  final Color? leadingColor;
  final VoidCallback? onBackPressed;
  final bool isCenterMode;
  final double? height;
  final double? elevation;
  final double? titleSpacing;
  final Alignment align;
  final EdgeInsets? contentPadding;
  final Widget? leading;
  final TextStyle? textStyle;
  final bool isCallPop;
  final bool useDefault;
  final Widget? customTitle;
  final double? paddingRight;
  final bool automaticallyImplyLeading;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final Widget? content;

  MyAppBar({
    Key? key,
    this.titleLabel,
    this.trailing,
    this.onBackPressed,
    this.bgColor,
    this.leadingColor,
    this.isCenterMode = false,
    this.height,
    this.elevation,
    this.titleSpacing,
    this.contentPadding,
    this.align = Alignment.center,
    this.leading,
    this.textStyle,
    this.isCallPop = true,
    this.useDefault = true,
    this.automaticallyImplyLeading = false,
    this.customTitle,
    this.paddingRight,
    this.systemUiOverlayStyle,
    this.content,
  })  : assert(
            content != null ||
                customTitle != null ||
                (customTitle == null && titleLabel != null) ||
                (useDefault && titleLabel != null),
            'Must provide at least one.'),
        super(key: key);

  @override
  Size get preferredSize => height != null
      ? Size.fromHeight(height!)
      : const Size.fromHeight(kToolbarHeight);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  bool get isAppleOS => Platform.isIOS || Platform.isMacOS;

  MainAxisAlignment get _axisAlignment => (widget.align == Alignment.center ||
          widget.align == Alignment.topCenter ||
          widget.align == Alignment.bottomCenter)
      ? (widget.trailing == null
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween)
      : (widget.align == Alignment.topLeft ||
              widget.align == Alignment.centerLeft ||
              widget.align == Alignment.bottomLeft)
          ? MainAxisAlignment.start
          : MainAxisAlignment.end;

  void _onBackPressed() {
    widget.onBackPressed?.call();
    if (widget.isCallPop) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  AppIcons get _leadingIcon =>
      isAppleOS ? AppIcons.appbarBackIOS : AppIcons.appbarBackAndroid;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      title: widget.content ??
          (widget.height != 0.0
              ? (!widget.useDefault
                  ? Padding(
                      padding: widget.contentPadding ?? EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: _axisAlignment,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkButton(
                            width: dimen_44.w,
                            height: dimen_44.w,
                            align: Alignment.center,
                            onTap: _onBackPressed,
                            child: widget.leading ??
                                AppIcon(
                                  _leadingIcon,
                                  width: dimen_24.w,
                                  height: dimen_24.w,
                                  color: Colors.black,
                                ),
                          ),
                          widget.customTitle ??
                              Text(
                                widget.titleLabel!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: widget.textStyle ??
                                    Theme.of(context).headerTitleTextStyle,
                              ),
                          widget.trailing ?? const SizedBox.shrink(),
                        ],
                      ),
                    )
                  : Text(
                      widget.titleLabel!,
                      style: Theme.of(context).headerTitleTextStyle,
                    ))
              : const SizedBox.shrink()),
      backgroundColor: widget.bgColor ?? Colors.transparent,
      toolbarHeight: widget.height,
      centerTitle: widget.isCenterMode,
      elevation: widget.elevation ?? dimen_4,
      titleSpacing: widget.titleSpacing,
      systemOverlayStyle: widget.systemUiOverlayStyle,
    );
  }
}
