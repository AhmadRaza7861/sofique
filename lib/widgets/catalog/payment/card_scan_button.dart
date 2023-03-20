import 'package:flutter/material.dart';

// Custom packages
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/screens/scan_your_card_screen.dart';

class CardScanButton extends StatelessWidget {
  const CardScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext _) {
            return ScanYourCardScreen();
          }),
        );
      },
      child: Container(
        child: Row(
          children: [
            PngIcon(image: 'assets/icons/camera-icon-black.png'),
            SizedBox(width: 14),
            Text(
              'SCAN YOUR CARD',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: 11,
                    letterSpacing: 0,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
