import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picker/utils/constants.dart';
import 'package:picker/utils/normalize.dart';
import 'package:picker/utils/text_style_common.dart';

class MyInputField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final int maxLength;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validateForm;
  final GlobalKey<FormFieldState>? textFormKey;
  final bool isPassword;
  final TextInputType textInputType;
  final int? maxLines;
  final int? minLines;
  final TextStyle? style;
  final TextStyle? hintStyle;

  const MyInputField({
    Key? key,
    this.controller,
    this.focusNode,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength = 255,
    this.validateForm,
    this.textFormKey,
    this.onChanged,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.minLines,
    this.maxLines,
    this.style,
    this.hintStyle,
  }) : super(key: key);

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  bool _hasFocus = false;
  late bool _obscureText;
  bool _isValidated = true;
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(() {
      _hasFocus = _focus.hasFocus;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextFormField(
        key: widget.textFormKey,
        minLines: widget.minLines ?? 1,
        maxLines: widget.maxLines ?? 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofocus: true,
        obscureText: _obscureText,
        focusNode: _focus,
        cursorColor: black,
        controller: widget.controller,
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
          if (widget.textFormKey != null) {
            setState(() {
              _isValidated = widget.textFormKey != null &&
                  widget.textFormKey!.currentState != null &&
                  widget.textFormKey!.currentState!.validate();
            });
          }
        },
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: widget.hintStyle ??
              TextStyleCommon.displaySubBody(context,
                  color: grey49, fontSize: 16),
          errorStyle:
              TextStyleCommon.displaySubBody(context, fontSize: 14, color: red),
          contentPadding: widget.minLines != null && widget.minLines! > 1
              ? EdgeInsets.all(normalize(12))
              : EdgeInsets.only(left: normalize(12)),
          suffixIcon: widget.suffixIcon ?? _renderObscureButton(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(normalize(8)),
            borderSide: BorderSide(
              width: 1,
              color: grey66,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(normalize(8)),
            borderSide: BorderSide(
              width: 1,
              color: red,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(normalize(8)),
            borderSide: BorderSide(
              width: 1,
              color: red,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(normalize(8)),
            borderSide: BorderSide(
              width: 1,
              color: lilac,
            ),
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        style: widget.style ??
            TextStyle(
              color: black,
              fontWeight: FontWeight.w600,
              fontSize: normalize(18),
              height: 25.0 / 18.0,
            ),
        keyboardType: widget.textInputType,
        validator: widget.validateForm,
      ),
    );
  }

  Widget _renderObscureButton() {
    if (_hasFocus && widget.isPassword == true) {
      return IconButton(
        icon: Icon(
          _obscureText == true ? Icons.visibility : Icons.visibility_off,
          color: _isValidated ? lilac : red,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return SizedBox.shrink();
  }
}
