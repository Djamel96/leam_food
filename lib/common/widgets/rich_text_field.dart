import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leamapp/common/models/app_colors.dart';

// todo: update postfix and password postfix icons code to be unified and more dynamic,
typedef VoidCallbackWithBoolArg = void Function(bool value);

class RichTextField extends StatefulWidget {
  final Key key;
  final TextEditingController controller;
  final String hintText;
  final TextStyle style;
  final TextStyle hintStyle;
  final bool obscureText;
  final bool autofocus;
  final Widget prefixIcon;
  final bool isprefixActiveIconDisabledSame;
  final Widget prefixIconDisabled;
  final Widget postfix;
  final VoidCallbackWithBoolArg onFocus;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final VoidCallback onTap;
  final bool readOnly;
  final ValueChanged<String> onChanged;
  final Widget stackTopLayer;
  final TextInputType keyboardType;
  final EdgeInsets contentPadding;
  final TextAlign textAlign;
  final List<TextInputFormatter> inputFormatters;
  final int maxLength;
  final String errorText;
  final String initialValue;
  final TextCapitalization textCapitalization;

  RichTextField({
    this.key,
    this.controller,
    this.style,
    this.hintText,
    this.hintStyle,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
    this.prefixIconDisabled,
    this.postfix,
    this.onFocus,
    this.validator,
    this.onSaved,
    this.onTap,
    this.onChanged,
    this.stackTopLayer,
    this.keyboardType,
    this.contentPadding,
    this.textAlign,
    this.inputFormatters,
    this.maxLength,
    this.errorText,
    this.initialValue,
    this.isprefixActiveIconDisabledSame = true,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  _RichTextFieldState createState() => _RichTextFieldState();
}

class _RichTextFieldState extends State<RichTextField> {
  FocusNode _focus = new FocusNode();
  Widget _prefixIcon;
  bool _hidePassword = false;
  bool _isPassword = false;

  @override
  void initState() {
    super.initState();
    _isPassword = (widget.obscureText != null) ? widget.obscureText : false;
    _hidePassword = _isPassword;
    _focus.addListener(_onFocusChange);
  }

  void _setPrefixIcon() {
    setState(() {
      // if (widget.prefixIconDisabled != null &&
      //     !_focus.hasFocus &&
      //     !widget.isprefixActiveIconDisabledSame) {
      //   _prefixIcon = widget.prefixIconDisabled;
      // } else {
      _prefixIcon = widget.prefixIcon;
      // }
    });
  }

  void _onFocusChange() {
    _setPrefixIcon();
    if (widget.onFocus != null) widget.onFocus(_focus.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    _setPrefixIcon();
    String langCode = "en";
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              initialValue: widget.initialValue,
              maxLength: widget.maxLength,
              textCapitalization: widget.textCapitalization,
              // when maxLength is setup, by default TextField widget will build a counter under it to display the chars count,
              // for now this counter is unneeded in all cases so we just return null:
              buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              textAlign: widget.textAlign ?? TextAlign.start,
              controller: widget.controller,
              readOnly: widget.readOnly,
              obscureText: _hidePassword,
              autocorrect: false,
              focusNode: _focus,
              cursorColor: MyColors.appMain100,
              autofocus: widget.autofocus,
              style: widget.style ??
                  const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff444444),
                      fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  prefixIcon: _prefixIcon,
                  filled: true,
                  fillColor: const Color(0xfff5f5f5),
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle ??
                      TextStyle(
                          color: const Color(0xff444444).withOpacity(0.5)),
                  contentPadding:
                      widget.contentPadding ?? const EdgeInsets.all(22),
                  // contentPadding: EdgeInsets.zero,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: MyColors.richtextFocus, width: 2),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xffff6d5f), width: 2),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xffff6d5f), width: 2),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  errorText: widget.errorText ?? null),
              validator: widget.validator,
              onSaved: widget.onSaved,
              onTap: widget.onTap,
              onChanged: widget.onChanged,
            ),
            Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: (widget.postfix != null)
                        ? widget.postfix
                        : (_isPassword == true)
                            ? InkWell(
                                child: Icon(
                                  _hidePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 22,
                                  color: MyColors.grey169,
                                ),
                                onTap: () {
                                  setState(() {
                                    _hidePassword = !_hidePassword;
                                  });
                                },
                              )
                            : Container(),
                  ),
                )),
            Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: (_isPassword == true)
                        ? InkWell(
                            child: Icon(
                              _hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 22,
                              color: MyColors.grey169,
                            ),
                            onTap: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                          )
                        : Container(),
                  ),
                )),
            Positioned.fill(child: widget.stackTopLayer ?? Container()),
          ],
        ),
      ],
    );
  }
}
