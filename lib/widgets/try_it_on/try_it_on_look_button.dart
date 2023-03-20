import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/controller/ms8Controller.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';

class TryItOnLookButton extends StatelessWidget {
  TryItOnLookButton({Key? key}) : super(key: key);
  final Ms8Controller lookcontroller = Get.put(Ms8Controller());
  final TryItOnProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // List LookList = tmo.Looklist;
    List lookList = [];
    lookList = tmo.looklist;

    return Obx((() {
      return tmo.lookname.value != "myselection" &&
              tmo.lookname.value != "m16" &&
              tmo.bottomSheetVisible.isFalse
          ? Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Color(0XFFF4F2F0).withOpacity(0.5),
              ),
              height: 60,
              width: 200,
              margin: EdgeInsets.symmetric(
                vertical: size.height * 0.01,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 4, vertical: size.width * 0.01),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    tmo.previouslook();
                  },
                  child: Icon(Icons.chevron_left,
                      color: Color.fromARGB(255, 0, 0, 0), size: 30),
                ),
                Expanded(
                  child: Text(
                    lookList[tmo.lookindex.value],
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 17,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    tmo.nextlook();
                  },
                  child: Icon(Icons.chevron_right,
                      color: Color.fromARGB(255, 0, 0, 0), size: 30),
                ),
              ]))
          : Container();
    }));
  }
}
