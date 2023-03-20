import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/widgets/makeover/make_over_tabs.dart';
import 'package:sofiqe/widgets/makeover/question_counter.dart';
import 'package:sofiqe/widgets/png_icon.dart';

import '../provider/try_it_on_provider.dart';

class MakeOverHair extends StatefulWidget {
  const MakeOverHair({Key? key}) : super(key: key);

  @override
  _MakeOverHairState createState() => _MakeOverHairState();
}

class _MakeOverHairState extends State<MakeOverHair> {
  bool isSelected = false;
  MakeOverProvider mop = Get.find();

  List<Map<String, dynamic>> data = [
    {
      "name": "Black",
      "image": "black.png",
    },
    {
      "name": "Brown",
      "image": "brown.png",
    },
    {
      "name": "Auburn",
      "image": "auburn.png",
    },
    {
      "name": "Red",
      "image": "red.png",
    },
    {
      "name": "Blonde",
      "image": "blonde.png",
    },
    {
      "name": "Grey",
      "image": "grey.png",
    },
    {
      "name": "White",
      "image": "white.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () => mop.previousQuestion(true),
            child: Container(
              height: 40,
              width: 15,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Transform.rotate(
                  angle: 3.14159,
                  child: PngIcon(image: 'assets/icons/arrow-2-white.png'),
                ),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 85),
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                'sofiqe',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.white,
                      fontSize: 25,
                      letterSpacing: 2.5,
                    ),
              ),
            ),
          ),
          actions: [
            // isSelected?
            // GestureDetector(
            //   behavior: HitTestBehavior.translucent,
            //   onTap: () => mop.nextQuestion(false),
            //   child: Row(
            //     children: [
            //       SizedBox(
            //         width: 2,
            //       ),
            //       Text('Next'),
            //       SizedBox(
            //         width: 5,
            //       ),

            //           Icon(Icons.arrow_forward),
            //       SizedBox(
            //         width: 2,
            //       ),
            //     ],
            //   ),
            // ):
            // SizedBox.shrink()
          ],
        ),
        body: Container(
          height: Get.height - AppBar().preferredSize.height - 20,
          width: Get.width,
          child: Column(
            children: [
              MakeOverTabs(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: QuestionCounter(
                      current: mop.currentQuestion.value + 1,
                      total: 12,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Please selected the closest colour to your hair. We know the images can not show every spectrum of the available natural colour.',
                  style: TextStyle(
                    color: Color(0xffF2CA8A),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return Container(
                      height: size.height / 12.4,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Colors.black),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 68,
                            width: 58,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/hair/${data[i]["image"]}"),
                                    fit: BoxFit.fill)),
                          ),
                          Container(
                            width: 150,
                            height: 42,
                            alignment: Alignment.center,
                            child: (data[i]["name"] == mop.hairColor)
                                ? Container(
                                    alignment: Alignment.center,
                                    width: 150,
                                    height: 42,
                                    child: (data[i]["name"] == mop.hairColor)
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: 150,
                                            height: 42,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                            child: Text(
                                              data[i]["name"],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              mop.hairColor = data[i]["name"];
                                              mop.hairColorCode =
                                                  data[i]["name"];
                                              Get.find<TryItOnProvider>()
                                                  .shair(data[i]["name"]);
                                              setState(() {
                                                isSelected = true;
                                              });
                                              mop.nextQuestion(true);
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                width: 150,
                                                height: 42,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.black,
                                                    border: Border.all(
                                                      color: Color(0xffF2CA8A),
                                                    )),
                                                child: Text(
                                                  data[i]["name"]!,
                                                  style: TextStyle(
                                                      color: Color(0xffF2CA8A),
                                                      fontSize: 14),
                                                )),
                                          ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      mop.hairColor = data[i]["name"];
                                      mop.hairColorCode = data[i]["name"];
                                      Get.find<TryItOnProvider>()
                                          .shair(data[i]["name"]);
                                      setState(() {
                                        isSelected = true;
                                      });
                                      mop.nextQuestion(true);
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: 150,
                                        height: 42,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.black,
                                            border: Border.all(
                                              color: Color(0xffF2CA8A),
                                            )),
                                        child: Text(
                                          data[i]["name"]!,
                                          style: TextStyle(
                                              color: Color(0xffF2CA8A),
                                              fontSize: 14),
                                        )),
                                  ),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
