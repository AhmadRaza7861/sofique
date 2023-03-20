import 'package:flutter/material.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';

class ColorSelector extends StatefulWidget {
  final Map<String, dynamic> optionMap;
  final Function options;
  final int type;
  const ColorSelector({Key? key, required this.optionMap, required this.options, required this.type}) : super(key: key);

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  stringToHex(String color) {
    color = color.toUpperCase().replaceAll("#", "");
    if (color.length == 6) {
      color = "FF" + color;
    }
    return int.parse(color, radix: 16);
  }

  late var _currentValue = widget.optionMap['values'][0]['option_type_id'];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...widget.optionMap['values'].map(
            (option) {
              return _ColorOption(
                value: option['option_type_id'],
                current: _currentValue,
                onTap: (newVal) {
                  _currentValue = newVal;
                  widget.options({'optionId': widget.optionMap['option_id'], 'optionValue': newVal});
                  setState(() {});
                },
                child: Icon(
                  Icons.circle,
                  color: Color(stringToHex(option['title'])),
                  size: 30,
                ),
              );
            },
          ).toList(),

          // _ColorOption(
          //   value: 0,
          //   current: _currentValue,
          //   onTap: (int newVal) {
          //     setState(() {
          //       _currentValue = newVal;
          //     });
          //   },
          // child: Icon(
          //   Icons.circle,
          //   color: Color(0xFFEF3758),
          //   size: 30,
          // ),
          // ),
          // _ColorOption(
          //   value: 1,
          //   current: _currentValue,
          //   onTap: (int newVal) {
          //     setState(() {
          //       _currentValue = newVal;
          //     });
          //   },
          //   child: Icon(
          //     Icons.circle,
          //     color: Color(0xFFCD786A),
          //     size: 30,
          //   ),
          // ),
          // _ColorOption(
          //   value: 2,
          //   current: _currentValue,
          //   onTap: (int newVal) {
          //     setState(() {
          //       _currentValue = newVal;
          //     });
          //   },
          //   child: Icon(
          //     Icons.circle,
          //     color: Color(0xFFD77294),
          //     size: 30,
          //   ),
          // ),
          // _ColorOption(
          //   value: 3,
          //   current: _currentValue,
          //   onTap: (int newVal) {
          //     setState(() {
          //       _currentValue = newVal;
          //     });
          //   },
          //   child: Icon(
          //     Icons.circle,
          //     color: Color(0xFFBA030C),
          //     size: 30,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  final int value;
  final int current;
  final Function onTap;
  final Widget child;
  const _ColorOption({Key? key, required this.child, required this.value, required this.current, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(value);
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: <Widget>[
            child,
            value == current
                ? Positioned(
                    top: -0.1,
                    right: -0.1,
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        color: SplashScreenPageColors.textColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.done,
                          color: AppColors.navigationBarSelectedColor,
                          size: 10,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ]),
        ),
      ),
    );
  }
}