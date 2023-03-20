import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final double height;
  final double width;
  final Color backgroundColor;
  final Widget? prefix;
  final Widget? backgroundWidget;
  final String placeHolder;
  final bool active;
  final Function? onTap;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final bool obscure;
  final bool isBeingEdited;
  final double? horizontalPadding;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  const SignUpFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.height = 50,
    this.width = 200,
    this.backgroundColor = Colors.white,
    this.prefix,
    this.backgroundWidget,
    this.placeHolder = '',
    this.focusNode,
    this.active = true,
    this.onTap,
    this.onSubmitted,
    this.obscure = false,
    this.isBeingEdited = false,
    this.horizontalPadding,
    this.inputFormatters,
    this.inputType,
  }) : super(key: key);

  @override
  State<SignUpFormField> createState() => _SignUpFormFieldState();
}

class _SignUpFormFieldState extends State<SignUpFormField> {
  late FocusNode node;

  @override
  void initState() {
    super.initState();
    node = FocusNode();
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
          node.requestFocus();
          setState(() {});
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02,
          horizontal: widget.horizontalPadding == null ? size.width * 0.1 : (widget.horizontalPadding as double),
        ),
        color: widget.isBeingEdited ? Color(0xFFF4F2F0) : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.label}',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFFB5A7A7),
                    fontSize: size.height * 0.013,
                    letterSpacing: 0.4,
                  ),
            ),
            SizedBox(height: size.height * 0.004),
            CupertinoTextField(
              onChanged: (value) {},
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap!();
                  node.requestFocus();
                  setState(() {});
                }
              },
              onSubmitted: widget.onSubmitted,
              focusNode: widget.focusNode,
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.inputType,
              padding: EdgeInsets.all(0),
              cursorWidth: 1,
              cursorHeight: size.height * 0.03,
              cursorColor: Colors.black,
              obscureText: widget.obscure,
              enabled: widget.active,
              placeholder: '${widget.placeHolder}',
              placeholderStyle: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFFB5A7A7),
                    fontSize: size.height * 0.025,
                    letterSpacing: 0.6,
                    // fontWeight: FontWeight.bold,
                  ),
              prefix: Container(
                // padding: EdgeInsets.symmetric(horizontal: 0),

                child: widget.prefix,
              ),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.025,
                    letterSpacing: 0.5,
                  ),
              controller: widget.controller,
              decoration: BoxDecoration(color: widget.active ? Colors.transparent : Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }
}
