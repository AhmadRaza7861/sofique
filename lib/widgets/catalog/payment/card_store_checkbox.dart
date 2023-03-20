import 'package:flutter/material.dart';

// Custom packages
import 'package:sofiqe/widgets/custom_check_box.dart';

class CardStoreCheckBox extends StatefulWidget {
  final Function callback;
  const CardStoreCheckBox({Key? key, required this.callback}) : super(key: key);

  @override
  _CardStoreCheckBoxState createState() => _CardStoreCheckBoxState();
}

class _CardStoreCheckBoxState extends State<CardStoreCheckBox> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CustomCheckBox(
            value: _value,
            onChanged: (bool newVal) {
              setState(() {
                widget.callback(newVal);
                _value = newVal;
              });
            },
          ),
          SizedBox(width: 10),
          Text(
            'STORE CARD',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: 11,
                  letterSpacing: 0,
                ),
          ),
        ],
      ),
    );
  }
}
