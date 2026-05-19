import 'package:flutter/material.dart';

class SharedTextFormField extends StatefulWidget {
  const SharedTextFormField({
    super.key,
    this.hintText,
    required this.controller,
    this.focusNode,
    this.isPassword = false,
    this.suffixIcon,
    required this.validator,
    this.textInputAction,
    this.keyboardType,
    this.onFieldSubmitted,
  });
  final String? hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool isPassword;
  final IconButton? suffixIcon;
  final FormFieldValidator validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;

  @override
  State<SharedTextFormField> createState() =>
      _SharedTextFormFieldState();
}

class _SharedTextFormFieldState extends State<SharedTextFormField> {
  late bool _passwordSecure;

  @override
  initState() {
    super.initState();
    _passwordSecure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _passwordSecure,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTapOutside: (event) => widget.focusNode?.unfocus(),
      validator: widget.validator,
      controller: widget.controller,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText ?? "",
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _passwordSecure = !_passwordSecure;
                  });
                },
                icon: Icon(
                  _passwordSecure
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              )
            : null,
      ),
    );
  }
}
