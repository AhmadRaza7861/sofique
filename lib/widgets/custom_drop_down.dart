import 'package:flutter/material.dart';
import 'package:sofiqe/widgets/png_icon.dart';

class CustomDropDown extends StatelessWidget {
  final String label;
  final List<dynamic> items;
  final dynamic initialValue;
  final double height;
  final double width;
  final Color backgroundColor;
  final Function callback;
  final Function getLabel;
  const CustomDropDown({
    Key? key,
    required this.label,
    required this.items,
    required this.callback,
    required this.initialValue,
    this.height = 50,
    this.width = 200,
    this.backgroundColor = Colors.white,
    required this.getLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 18),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: backgroundColor,
            ),
            child: DropdownButton(
              value: initialValue,
              onChanged: (dynamic newVal) {
                callback(newVal);
              },
              underline: Container(),
              isExpanded: true,
              icon: PngIcon(
                image: 'assets/icons/dropdown_black.png',
                width: 9,
                height: 5,
              ),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(getLabel(item)),
                );
              }).toList(),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
