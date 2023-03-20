import 'package:flutter/material.dart';
import 'package:sofiqe/widgets/blinkingeffect.dart';

class BonousPointAlert extends StatefulWidget {
  const BonousPointAlert({super.key});

  @override
  State<BonousPointAlert> createState() => _BonousPointAlertState();
}

class _BonousPointAlertState extends State<BonousPointAlert> {
  bool showWidget = false;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        showWidget = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showWidget
        ? BlinkingAnimation(
            widget: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFFBBF8D1),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Order now and get more bonus points after payment',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Arial, Regular',
                        color: Color(0xFF389D5A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ))
        : Container(
            height: 23,
          );
  }
}
