import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/widgets/makeover/make_over_tabs.dart';
import 'package:sofiqe/widgets/makeover/question_counter.dart';
import 'package:sofiqe/widgets/png_icon.dart';

import '../provider/try_it_on_provider.dart';

class MokeOverEye extends StatefulWidget {
  const MokeOverEye({Key? key}) : super(key: key);

  @override
  _MokeOverEyeState createState() => _MokeOverEyeState();
}

class _MokeOverEyeState extends State<MokeOverEye> {
  bool isSelected = false;
  String selectedEye = '';

  //COLOUR CODE UPDATE
  List<Map<String, dynamic>> data = [
    {
      "name": "Amber",
      "image": "ambereye.png",
    },
    {
      "name": "Blue",
      "image": "blueeye.png",
    },
    {
      "name": "Brown",
      "image": "browneye.png",
    },
    {
      "name": "Grey",
      "image": "greyeye.png",
    },
    {
      "name": "Green",
      "image": "greeneye.png",
    },
    {
      "name": "Hazel",
      "image": "hazel.png",
    },
    {
      "name": "Red and voilet",
      "image": "redeye.png",
    },
  ];

  MakeOverProvider mop = Get.find();

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
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 40,
                  width: 15,
                  child: Transform.rotate(
                    angle: 3.14159,
                    child: PngIcon(image: 'assets/icons/arrow-2-white.png'),
                  ),
                ),
              )),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 85),
            child: Text(
              'sofiqe',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: 25,
                    letterSpacing: 2.5,
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
          height: (Get.height * 0.9) - AppBar().preferredSize.height - 20,
          width: Get.width,
          child: Column(
            children: <Widget>[
              //    Padding(
              //   padding:  EdgeInsets.only(left: 12,right: 12),
              //   child: QuestionController(flowfromIngredients: true,),
              // ),
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
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Text(
                  'What colour does your eyes have?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
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
                      height: size.height / 12.7,
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
                                        "assets/images/eye/${data[i]["image"]}"),
                                    fit: BoxFit.fill)),
                          ),
                          Container(
                            height: 42,
                            width: 150,
                            alignment: Alignment.center,
                            child: (data[i]["name"] == mop.selectedEye)
                                ? InkWell(
                                    onTap: () {
                                      mop.selectedEye = data[i]["name"];
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
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        data[i]["name"],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      mop.selectedEye = data[i]["name"];
                                      mop.selectedEyeCode = data[i]["name"];
                                      Get.find<TryItOnProvider>()
                                          .seye(data[i]["name"]);
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
                                                color: Color(0xffF2CA8A))),
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
