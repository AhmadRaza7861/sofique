import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogue {
  static showGetError(String msg, {String title = "", int msglength = 150}) {
    String errortoShow =
        msg.toString().length > msglength ? msg.toString().substring(0, msglength - 1) : msg.toString();
    Get.defaultDialog<bool>(
        title: '',
        titleStyle: const TextStyle(fontSize: 1),
        radius: 18,
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.only(top: 17, left: 16, right: 16, bottom: 5),
        content: Column(
          children: [
            Image.asset(
              'assets/images/warning.png'.toString(),
              height: 30,
            ),
            Text(
              'sofiqe',
              style: Get.textTheme.headline1!
                  .copyWith(color: Colors.black, fontSize: 35, fontWeight: FontWeight.w500, letterSpacing: 0.6),
            ),
            SizedBox(
              height: 14,
            ),
            if (title.isNotEmpty)
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (title.isNotEmpty)
              SizedBox(
                height: 7,
              ),
            Text(
              errortoShow,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ));
  }
}
