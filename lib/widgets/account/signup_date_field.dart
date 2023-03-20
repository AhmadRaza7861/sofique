import 'package:flutter/material.dart';

class SignUpDateField extends StatefulWidget {
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
  final bool obscure;
  final bool isBeingEdited;
  const SignUpDateField({
    Key? key,
    required this.label,
    required this.controller,
    this.height = 50,
    this.width = 200,
    this.backgroundColor = Colors.white,
    this.prefix,
    this.backgroundWidget,
    this.placeHolder = '',
    this.active = true,
    this.onTap,
    this.obscure = false,
    this.isBeingEdited = false,
  }) : super(key: key);

  @override
  _SignUpDateFieldState createState() => _SignUpDateFieldState();
}

class _SignUpDateFieldState extends State<SignUpDateField> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    widget.controller.addListener(() {
      setState(() {});
    });
    // controller.
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.width * 0.1),
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
          Text(
            '${widget.controller.value.text}',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.025,
                  letterSpacing: 0.4,
                ),
          ),
        ],
      ),
    );
  }
}
