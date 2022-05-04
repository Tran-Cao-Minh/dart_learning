import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';

const String _kEmptyString = '';
const int kDefaultErrorMaxLines = 2;
const int kDefaultHelperMaxLines = 2;
const int kDefaultMinLines = 1;
const int kDefaultMaxLines = 1;

enum TextInputStyle { normal, search }

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _Counter extends StatelessWidget {
  final int? currentLength;
  final int? maxLength;
  final EdgeInsets? paddingRemaining;

  _Counter({
    Key? key,
    required this.currentLength,
    required this.maxLength,
    required this.paddingRemaining,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: paddingRemaining ??
          EdgeInsets.only(
            right: dimen_16.w,
          ),
      child: Text(
        currentLength.toCountCharactersRemaining(maxLength: maxLength),
      ),
    );
  }
}

class _Prefix extends StatelessWidget {
  final Widget prefixIcon;

  _Prefix({
    Key? key,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: dimen_12.w,
        right: dimen_8.w,
      ),
      child: prefixIcon,
    );
  }
}

class _RenderSuffixClearIcon extends StatelessWidget {
  final VoidCallback onClearText;

  const _RenderSuffixClearIcon({
    Key? key,
    required this.onClearText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: dimen_7.w,
      ),
      child: InkButton(
        borderRadius: dimen_24,
        onTap: onClearText,
        highlightColor: Colors.transparent,
        width: dimen_24.w,
        child: AppIcon(
          AppIcons.inputClose,
          width: dimen_24.w,
          height: dimen_24.h,
        ),
      ),
    );
  }
}

class BasisInputField extends StatefulWidget {
  /// set auto focus for text input after text input draw on widget tree
  final bool autoFocus;

  /// set focusNode
  final bool enableInteractiveSelection;

  final bool autoCorrect;
  final bool obscureText;
  final bool enabled;

  /// if [true] and has initialValue is notEmpty will show clear button
  final bool showClearButton;

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool autoValidate;
  final TextStyle? hintStyle;
  final TextStyle? counterStyle;
  final TextStyle? errorStyle;
  final TextStyle? textFieldStyle;
  final List<TextInputFormatter>? inputFormatter;
  final Function(bool hasFocus)? onFocusChange;
  final TextInputAction? textInputAction;
  final Function(String text)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final int? errorMaxLines;
  final int? helperMaxLines;
  final FocusNode? focusNode;
  final Function(bool isFocus)? onFocus;
  final EdgeInsets? contentPadding;
  final VoidCallback? onClearText;
  final ValueKey? textInputKey;
  final bool alwaysShowHint;
  final ToolbarOptions? toolbarOptions;
  final TextInputStyle? textInputStyle;
  final InputBorder? border;
  final OutlineInputBorder? focusBorder;
  final VoidCallback? onEditingComplete;
  final double? leadingPadding;
  final Color? cursorColor;
  final bool isShowLabel;

  /// set padding for counter widget
  final EdgeInsets? paddingRemaining;

  /// set background color text input
  final Color? bgColor;

  final Color? focusBgColor;

  final Function(bool hintTextValue)? setHintTextValue;

  BasisInputField({
    Key? key,
    this.textInputStyle = TextInputStyle.normal,
    this.autoFocus = false,
    this.autoCorrect = false,
    this.obscureText = false,
    this.enabled = true,
    this.isShowLabel = false,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.counterStyle,
    this.errorStyle,
    this.onChanged,
    this.prefixIcon,
    this.helperText,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.validator,
    this.autoValidate = false,
    this.showClearButton = false,
    this.onTap,
    this.initialValue,
    this.onSaved,
    this.inputFormatter,
    this.onFocusChange,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.errorMaxLines = kDefaultErrorMaxLines,
    this.helperMaxLines = kDefaultHelperMaxLines,
    this.enableInteractiveSelection = false,
    this.focusNode,
    this.onFocus,
    this.textFieldStyle,
    this.contentPadding,
    this.onClearText,
    this.textInputKey,
    this.alwaysShowHint = false,
    this.toolbarOptions,
    this.paddingRemaining,
    this.bgColor,
    this.focusBgColor,
    this.setHintTextValue,
    this.border,
    this.focusBorder,
    this.leadingPadding,
    this.cursorColor,
  }) : super(key: key);

  @override
  _BasisInputFieldState createState() => _BasisInputFieldState();
}

class _BasisInputFieldState extends State<BasisInputField> {
  late FocusNode _focus;
  bool hintTextValue = true;
  bool autoFocus = false;
  late int currentLength;
  TextEditingController? _controller;

  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  bool isFocused = false, isClearBtnShowing = false;
  late bool _enabled;
  String? _labelText;

  @override
  void initState() {
    super.initState();
    _enabled = widget.enabled;
    if (widget.focusNode != null) {
      _focus = widget.focusNode!;
    } else {
      _focus = FocusNode();
    }

    _focus.addListener(_onFocusChange);
    autoFocus = widget.autoFocus;
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      if (widget.controller!.text.isNotEmpty) {
        _labelText = widget.labelText;
      }
    }

    currentLength = _effectiveController?.text.length ?? 0;
  }

  @override
  void didUpdateWidget(BasisInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _controller =
          TextEditingController.fromValue(oldWidget.controller?.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      _controller = null;
    }

    if (oldWidget.enabled != widget.enabled) {
      setState(() {
        _enabled = !_enabled;
      });
    }
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    if (_controller != null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focus.hasFocus;
      if (_focus.hasFocus ||
          (_effectiveController != null &&
              _effectiveController!.text.isNotEmpty)) {
        hintTextValue = false;
      } else {
        hintTextValue = true;
      }
    });
    widget.onFocusChange?.call(_focus.hasFocus);
    widget.onFocus?.call(_focus.hasFocus);
    widget.setHintTextValue?.call(hintTextValue);
  }

  void _onTextChanged(String text) {
    final shouldShowClearBtn = widget.showClearButton && text.isNotEmpty;
    if (isClearBtnShowing != shouldShowClearBtn) {
      setState(() {
        isClearBtnShowing = shouldShowClearBtn;
      });
    }
    widget.onChanged?.call(text);
  }

  void _onClearText() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.controller != null) {
        widget.controller!.clear();
      } else {
        _controller?.clear();
      }

      return _onTextChanged(_kEmptyString);
    });

    widget.onClearText?.call();
  }

  void _setFocus(BuildContext context) {
    if (autoFocus) {
      FocusScope.of(context).requestFocus(_focus);
      autoFocus = false;
    }
  }

  void _onHandleLabel(String value) {
    if (value.isNotEmpty) {
      _labelText = widget.labelText;
    } else {
      _labelText = null;
    }
  }

  void _handleOnChange(String value) {
    setState(() {
      currentLength = value.length;
    });
    _onHandleLabel(value);
    _onTextChanged(value);
  }

  String? get _getHint {
    if (widget.alwaysShowHint) {
      return widget.hintText;
    }

    return widget.hintText;
  }

  Color? get _getBackgroundColor {
    return widget.bgColor;
  }

  InputBorder? _getBorder() {
    if (widget.textInputStyle == TextInputStyle.search) {
      return null;
    }

    return widget.border ?? Theme.of(context).inputDecorationTheme.border;
  }

  InputBorder? _getEnabledBorder() {
    return widget.border ??
        Theme.of(context).inputDecorationTheme.enabledBorder;
  }

  InputBorder? _getFocusedBorder() {
    return widget.focusBorder ??
        Theme.of(context).inputDecorationTheme.focusedBorder;
  }

  InputBorder? _getFocusedErrorBorder() {
    if (widget.textInputStyle == TextInputStyle.search) {
      return null;
    }

    return Theme.of(context).inputDecorationTheme.focusedErrorBorder;
  }

  InputBorder? _getErrorBorder() {
    if (widget.textInputStyle == TextInputStyle.search) {
      return null;
    }

    return Theme.of(context).inputDecorationTheme.errorBorder;
  }

  InputBorder? _getDisabledBorder() {
    if (widget.textInputStyle == TextInputStyle.search) {
      return null;
    }

    return Theme.of(context).inputDecorationTheme.disabledBorder;
  }

  TextInputAction _getTextInputAction() {
    if (widget.textInputStyle == TextInputStyle.search) {
      return TextInputAction.search;
    }

    return widget.textInputAction ?? TextInputAction.next;
  }

  InputDecoration _getInputDecoration() {
    final remainingCharLength =
        (widget.maxLength != null) ? widget.maxLength! - currentLength : null;
    return InputDecoration(
        hintText: _getHint,
        labelText: widget.isShowLabel ? _labelText : null,
        hintMaxLines: 1,
        helperText: widget.helperText,
        prefixIcon: widget.prefixIcon != null
            ? _Prefix(
                prefixIcon: widget.prefixIcon!,
              )
            : null,
        suffixIcon: widget.suffixIcon ??
            (isClearBtnShowing
                ? (isFocused
                    ? _RenderSuffixClearIcon(
                        onClearText: _onClearText,
                      )
                    : null)
                : null),
        hintStyle: widget.hintStyle,
        counterStyle: widget.counterStyle,
        errorStyle: widget.errorStyle,
        border: _getBorder(),
        focusedBorder: _getFocusedBorder(),
        enabledBorder: _getEnabledBorder(),
        focusedErrorBorder: _getFocusedErrorBorder(),
        errorBorder: _getErrorBorder(),
        disabledBorder: _getDisabledBorder(),
        prefixIconConstraints: BoxConstraints(
          minWidth: dimen_24.w,
          minHeight: dimen_24.h,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: dimen_24.w,
          minHeight: dimen_24.h,
        ),
        isDense: true,
        counter: (remainingCharLength != null)
            ? _Counter(
                currentLength: currentLength,
                maxLength: widget.maxLength,
                paddingRemaining: widget.paddingRemaining,
              )
            : null);
  }

  @override
  Widget build(BuildContext context) {
    _setFocus(context);
    return Material(
      color: Colors.transparent,
      child: TextFormField(
        key: widget.textInputKey ?? const ValueKey('basis_text_input_key'),
        enableInteractiveSelection: widget.enableInteractiveSelection,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        cursorColor: widget.cursorColor,
        cursorWidth: dimen_2.w,
        autocorrect: widget.autoCorrect,
        autofocus: widget.autoFocus,
        enabled: _enabled,
        controller: _effectiveController,
        onChanged: _handleOnChange,
        toolbarOptions: widget.toolbarOptions,
        onSaved: widget.onSaved,
        focusNode: widget.enableInteractiveSelection
            ? _focus
            : AlwaysDisabledFocusNode(),
        validator: widget.validator,
        autovalidateMode: widget.autoValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        onTap: widget.onTap,
        style: widget.textFieldStyle,
        decoration: _getInputDecoration().applyDefaults(
          InputDecorationTheme(
            fillColor: _getBackgroundColor,
            filled: true,
            errorMaxLines: widget.errorMaxLines,
            helperMaxLines: widget.helperMaxLines,
            contentPadding: EdgeInsets.only(
              left: widget.leadingPadding ?? dimen_16.w,
              top: dimen_13.h,
              bottom: dimen_13.h,
            ),
            alignLabelWithHint: true,
            isDense: true,
          ),
        ),
        inputFormatters: widget.inputFormatter,
        textInputAction: _getTextInputAction(),
        onFieldSubmitted: widget.onFieldSubmitted,
        onEditingComplete: widget.onEditingComplete,
        maxLength: widget.maxLength,
        minLines: widget.minLines ?? kDefaultMinLines,
        maxLines: widget.maxLines ?? kDefaultMaxLines,
      ),
    );
  }
}
