import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picker/common/common.dart';
import 'package:picker/constants/constants.dart';
import 'package:picker/presentation/theme/theme.dart';
import 'basis_input_field.dart';

extension MyInputFieldExtension on ThemeData {
  TextStyle get inputFieldTextStyle => primaryBodyMedium.copyWith(
        color: black3333,
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get inputFieldDisabledStyle => primaryBodyMedium.copyWith(
        color: black6666,
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get inputFieldHintStyle => primaryBodyMedium.copyWith(
        color: black9999,
        fontSize: dimen_16.sp,
        height: dimen_20.sp.toLineHeight(dimen_16.sp),
      );

  TextStyle get inputFieldErrorStyle => primaryBodySmall.copyWith(
        color: redDD0F,
        fontSize: dimen_14.sp,
        height: dimen_20.sp.toLineHeight(dimen_14.sp),
      );

  TextStyle get inputFieldCounterStyle => primaryBodyMedium.copyWith(
        color: black11834Opacity50,
        fontSize: dimen_14.sp,
        height: dimen_20.sp.toLineHeight(dimen_14.sp),
      );
}

extension TextEditingValueInfo on TextEditingValue {
  TextEditingValue get getFormattedPhoneNumber {
    return TextEditingValue(
      text: text.toFormatterPhoneInput,
      selection: TextSelection.fromPosition(
        TextPosition(
          offset: text.toFormatterPhoneInput.length,
        ),
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  PhoneNumberFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue _,
    TextEditingValue newValue,
  ) {
    return newValue.getFormattedPhoneNumber;
  }
}

class MyInputField extends BasisInputField {
  MyInputField({
    bool autoFocus = false,
    bool autoCorrect = false,
    bool obscureText = false,
    bool enabled = true,
    bool autoValidate = false,
    bool showClearButton = false,
    bool enableInteractiveSelection = true,
    bool alwaysShowHint = false,
    bool isShowLabel = false,
    String? hintText,
    String? labelText,
    String? helperText,
    String? initialValue,
    ValueChanged<String>? onChanged,
    Widget? prefixIcon,
    VoidCallback? onTap,
    TextEditingController? controller,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatter,
    Function(bool hasFocus)? onFocusChange,
    TextInputAction? textInputAction,
    Function(String text)? onFieldSubmitted,
    Function(String?)? onSaved,
    int? maxLength,
    int? minLines,
    int? maxLines,
    int? errorMaxLines,
    int? helperMaxLines,
    FocusNode? focusNode,
    Function(bool isFocus)? onFocus,
    VoidCallback? onClearText,
    ValueKey? textInputKey,
    ToolbarOptions? toolbarOptions,
    Function(bool hintTextValue)? setHintTextValue,
    required TextInputStyle textInputStyle,
    InputBorder? border,
    OutlineInputBorder? focusBorder,
    VoidCallback? onEditingComplete,
    Color? cursorColor,
    Color? bgColor,
    TextStyle? labelStyle,
    TextStyle? textFieldStyle,
    TextStyle? disabledStyle,
    TextStyle? hintStyle,
    TextStyle? counterStyle,
    TextStyle? errorStyle,
    double? leadingPadding,
    Color? focusBgColor,
    Color? disabledColor,
    Widget? suffixIcon,
  }) : super(
          key: textInputKey,
          autoFocus: autoFocus,
          autoCorrect: autoCorrect,
          obscureText: obscureText,
          enabled: enabled,
          hintText: hintText,
          labelText: labelText,
          onChanged: onChanged,
          prefixIcon: prefixIcon,
          helperText: helperText,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          autoValidate: autoValidate,
          showClearButton: showClearButton,
          onTap: onTap,
          initialValue: initialValue,
          onSaved: onSaved,
          inputFormatter: inputFormatter,
          onFocusChange: onFocusChange,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines,
          errorMaxLines: errorMaxLines,
          helperMaxLines: helperMaxLines,
          enableInteractiveSelection: enableInteractiveSelection,
          focusNode: focusNode,
          onFocus: onFocus,
          onClearText: onClearText,
          textInputKey: textInputKey,
          alwaysShowHint: alwaysShowHint,
          toolbarOptions: toolbarOptions,
          setHintTextValue: setHintTextValue,
          textFieldStyle: enabled ? textFieldStyle : disabledStyle,
          hintStyle: hintStyle,
          counterStyle: counterStyle,
          errorStyle: errorStyle,
          bgColor: enabled ? bgColor : disabledColor,
          focusBgColor: focusBgColor,
          textInputStyle: textInputStyle,
          border: border,
          focusBorder: focusBorder,
          onEditingComplete: onEditingComplete,
          leadingPadding: leadingPadding,
          cursorColor: cursorColor,
          isShowLabel: isShowLabel,
          suffixIcon: suffixIcon,
        );

  factory MyInputField.single(
    BuildContext context, {
    bool autoFocus = false,
    bool autoCorrect = false,
    bool obscureText = false,
    bool enabled = true,
    bool enableInteractiveSelection = true,
    bool autoValidate = false,
    bool showClearButton = false,
    bool alwaysShowHint = false,
    String? hintText,
    String? helperText,
    String? initialValue,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    TextEditingController? controller,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatter,
    Function(bool hasFocus)? onFocusChange,
    required TextInputAction? textInputAction,
    Function(String text)? onFieldSubmitted,
    Function(String?)? onSaved,
    int? maxLength,
    int errorMaxLines = kDefaultErrorMaxLines,
    int helperMaxLines = kDefaultHelperMaxLines,
    FocusNode? focusNode,
    Function(bool isFocus)? onFocus,
    VoidCallback? onClearText,
    ValueKey? textInputKey,
    ToolbarOptions? toolbarOptions,
    Function(bool hintTextValue)? setHintTextValue,
    InputBorder? border,
    VoidCallback? onEditingComplete,
    Color? cursorColor,
    Color? bgColor,
    TextStyle? textFieldStyle,
    TextStyle? disabledStyle,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
    Widget? suffixIcon,
  }) {
    return MyInputField(
      autoFocus: autoFocus,
      autoCorrect: autoCorrect,
      obscureText: obscureText,
      enabled: enabled,
      autoValidate: autoValidate,
      showClearButton: showClearButton,
      enableInteractiveSelection: enableInteractiveSelection,
      alwaysShowHint: alwaysShowHint,
      hintText: hintText,
      helperText: helperText,
      initialValue: initialValue,
      onChanged: onChanged,
      onTap: onTap,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatter: inputFormatter,
      onFocusChange: onFocusChange,
      textInputAction: textInputAction,
      textInputStyle: TextInputStyle.normal,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      maxLength: maxLength,
      errorMaxLines: errorMaxLines,
      helperMaxLines: helperMaxLines,
      focusNode: focusNode,
      onFocus: onFocus,
      onClearText: onClearText,
      textInputKey: textInputKey,
      toolbarOptions: toolbarOptions,
      setHintTextValue: setHintTextValue,
      border: border,
      onEditingComplete: onEditingComplete,
      cursorColor: blue1976,
      minLines: 1,
      maxLines: 1,
      suffixIcon: suffixIcon,
      bgColor: bgColor,
      disabledColor: blackF1F1,
      focusBgColor: white,
      textFieldStyle: textFieldStyle ?? Theme.of(context).inputFieldTextStyle,
      disabledStyle: disabledStyle ?? Theme.of(context).inputFieldDisabledStyle,
      hintStyle: hintStyle ?? Theme.of(context).inputFieldHintStyle,
      errorStyle: errorStyle ?? Theme.of(context).inputFieldErrorStyle,
    );
  }

  factory MyInputField.area(
    BuildContext context, {
    bool autoFocus = false,
    bool autoCorrect = false,
    bool autoValidate = false,
    String? hintText,
    String? helperText,
    String? initialValue,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatter,
    Function(bool hasFocus)? onFocusChange,
    required TextInputAction? textInputAction,
    Function(String text)? onFieldSubmitted,
    Function(String?)? onSaved,
    int? maxLength,
    int errorMaxLines = kDefaultErrorMaxLines,
    int helperMaxLines = kDefaultHelperMaxLines,
    FocusNode? focusNode,
    Function(bool isFocus)? onFocus,
    ValueKey? textInputKey,
    ToolbarOptions? toolbarOptions,
    Function(bool hintTextValue)? setHintTextValue,
    InputBorder? border,
    VoidCallback? onEditingComplete,
    Color? cursorColor,
    Color? bgColor,
    TextStyle? textFieldStyle,
    TextStyle? disabledStyle,
    TextStyle? hintStyle,
    TextStyle? counterStyle,
    TextStyle? errorStyle,
  }) {
    return MyInputField(
      autoFocus: autoFocus,
      autoCorrect: autoCorrect,
      obscureText: false,
      enabled: true,
      autoValidate: autoValidate,
      showClearButton: false,
      enableInteractiveSelection: true,
      alwaysShowHint: true,
      hintText: hintText,
      helperText: helperText,
      initialValue: initialValue,
      onChanged: onChanged,
      onTap: onTap,
      controller: controller,
      keyboardType: TextInputType.text,
      textInputStyle: TextInputStyle.normal,
      validator: validator,
      inputFormatter: inputFormatter,
      onFocusChange: onFocusChange,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      maxLength: maxLength,
      errorMaxLines: errorMaxLines,
      helperMaxLines: helperMaxLines,
      focusNode: focusNode,
      onFocus: onFocus,
      textInputKey: textInputKey,
      toolbarOptions: toolbarOptions,
      setHintTextValue: setHintTextValue,
      border: border,
      onEditingComplete: onEditingComplete,
      cursorColor: blue1976,
      minLines: 4,
      maxLines: 8,
      bgColor: bgColor,
      disabledColor: blackF1F1,
      focusBgColor: white,
      textFieldStyle: textFieldStyle ?? Theme.of(context).inputFieldTextStyle,
      disabledStyle: disabledStyle ?? Theme.of(context).inputFieldDisabledStyle,
      hintStyle: hintStyle ?? Theme.of(context).inputFieldHintStyle,
      errorStyle: errorStyle ?? Theme.of(context).inputFieldErrorStyle,
      counterStyle: counterStyle ?? Theme.of(context).inputFieldCounterStyle,
    );
  }

  factory MyInputField.search(
    BuildContext context, {
    bool shouldShowSearchIcon = true,
    String? hintText,
    String? initialValue,
    ValueChanged<String>? onChanged,
    VoidCallback? onSuffixBtnPressed,
    VoidCallback? onTap,
    TextEditingController? controller,
    List<TextInputFormatter>? inputFormatter,
    Function(bool hasFocus)? onFocusChange,
    Function(String text)? onFieldSubmitted,
    Function(String?)? onSaved,
    int minLines = 1,
    int maxLines = 1,
    FocusNode? focusNode,
    Function(bool isFocus)? onFocus,
    VoidCallback? onClearText,
    ValueKey? textInputKey,
    ToolbarOptions? toolbarOptions,
    Function(bool hintTextValue)? setHintTextValue,
    VoidCallback? onEditingComplete,
    Widget? prefixIcon,
  }) {
    return MyInputField(
      autoFocus: false,
      enabled: true,
      autoCorrect: false,
      showClearButton: true,
      alwaysShowHint: false,
      enableInteractiveSelection: true,
      hintText: hintText,
      initialValue: initialValue,
      onChanged: onChanged,
      inputFormatter: inputFormatter,
      prefixIcon: shouldShowSearchIcon
          ? AppIcon(
              AppIcons.inputSearch,
              width: dimen_24.w,
              height: dimen_24.h,
            )
          : null,
      onTap: onTap,
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      onFocusChange: onFocusChange,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      focusNode: focusNode,
      onFocus: onFocus,
      onClearText: onClearText,
      textInputKey: textInputKey,
      toolbarOptions: toolbarOptions,
      setHintTextValue: setHintTextValue,
      textInputStyle: TextInputStyle.search,
      onEditingComplete: onEditingComplete,
      cursorColor: blue1976,
      bgColor: Colors.white,
      textFieldStyle: Theme.of(context).inputFieldTextStyle,
      hintStyle: Theme.of(context).inputFieldHintStyle,
    );
  }
}
