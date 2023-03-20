import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sofiqe/controller/ms8Controller.dart';
import 'package:sofiqe/controller/selectedProductController.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/my_sofiqe.dart';

class TryItOnColorSelector extends StatefulWidget {
  TryItOnColorSelector({Key? key}) : super(key: key);

  @override
  State<TryItOnColorSelector> createState() => _TryItOnColorSelectorState();
}

class _TryItOnColorSelectorState extends State<TryItOnColorSelector> {
  ScrollController controler = ScrollController();
  Ms8Controller lookcontroller = Get.find();
  SelectedProductController selectedcontroller = Get.find();
  final TryItOnProvider tmo = Get.find();
  CarouselController _carouselController = CarouselController();

  getdata() async {
    if (tmo.lookname.value == "myselection") await tmo.getCentralColors();

    if (tmo.lookname.value == "m16")
      await tmo.getAlternateColors(tmo.currentSelectedCentralColor['code'], tmo.selectedFaceArea.toString(), "5");
    print(tmo.alternateColors);
    print("object");
  }

  @override
  void initState() {
    super.initState();
    // tmo.isSelectColor.value=false;
    // tmo.isSelectColorIndex.value = 10000;
    // tmo.isSelectColor.value=false;
    // tmo.isSelectColorIndex.value = 10000;
    // getdata();
    // tmo.setSelectedToDefault();
    controler = ScrollController();
  }
  indexChecker(int index){

    log('=======  second one is calling  =======');

    List colorList = tmo.alternateColors;

    int check =   colorList.indexWhere((element) => element == tmo.currentSelectedColor.value);
    log('=======  second one is calling  ======='+check.toString());
    tmo.matchColorIndex.value = check;
    if(check == -1){
      tmo.showSelected.value = true;
      // return -1;
    } else {
      // log(index.toString());
      // log('=======  Index  ======='+check.toString());

      if(index == check) {
        log('======= yes now both are same =====');
        tmo.showSelected.value = false;
        log('======= yes now both are same value is ${tmo.showSelected.value} =====');
      } else {
        log('======= no same :: value is ${tmo.showSelected.value}  =====');
        tmo.showSelected.value = true;
      }
      log('=====  color index is $check   ======');
      // return check;
    }
  }

int intialIndex=0;
  int returnIndexIfAvailable() {
if(tmo.isFirstCalling.isTrue){
  tmo.isFirstCalling.value=false;
    log('=======  first one is calling  =======');
    List colorList = tmo.alternateColors;


    int check =   colorList.indexWhere((element) => element == tmo.currentSelectedColor.value);
  tmo.matchColorIndex.value = check;
    if(check == -1){
      tmo.outerIndex.value = 0;
      // tmo.outerIndex.value = 10000;
      indexChecker(0);
      // indexChecker(10000);
      intialIndex = 0;
      return check;
    } else {
      tmo.outerIndex.value = check;
      indexChecker(check);
        intialIndex=check;
      return check;
    }
}else{return intialIndex;}
  }

  @override
  Widget build(BuildContext context) {
    print("tmo.AlternateColors.first");
    print(tmo.alternateColors);
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      List colorList = tmo.alternateColors;
      // int outerIndex = -2;
      return SizedBox(
          child: Center(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _carouselController.previousPage();
                  },
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 16),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: size.height * 0.08 + size.height * 0.006 + size.width * 0.01,
                    maxWidth: size.width/2.3,
                  ),
                  width: size.width * 0.6 - 42,
                  margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: size.width * 0.01),
                  // color: Color.fromARGB(255, 255, 255, 255),
                  child: tmo.alternateColorsloading.value == true
                      ? Center(
                    child:
                    SpinKitDoubleBounce(
                      color: Color(0xffF2CA8A),
                      size: 35.0,
                    ),
                  )
                      : colorList.isNotEmpty
                      ?

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                            height: 400,
                            // aspectRatio: 16/9,
                            viewportFraction: 0.33,
                            initialPage: returnIndexIfAvailable() == -1 ? 0 : returnIndexIfAvailable(),
                            // initialPage: returnIndexIfAvailable() == -1 ? 0 : returnIndexIfAvailable(),
                            // initialPage:        tmo.currentSelectedColor.value == colorList[tmo.isSelectColor.value > colorList.length ? 0 : tmo.isSelectColor.value]  == -1 ? 0 :       tmo.currentSelectedColor.value == colorList[tmo.isSelectColor.value > colorList.length ? 0 : tmo.isSelectColor.value],
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: false,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              // log(index.toString());
                              // log("On Carasole Index Check");
                              // // setState(() {
                                 tmo.outerIndex.value = index;
                                indexChecker(index);
                                // tmo.isSelectColorIndex.value = index;
                                // print("tmo.isSelectColor.value ${tmo.isSelectColorIndex.value} and ${index}");
                              // });
                            },
                          ),
                          items: List.generate(colorList.length, (index) {

                            return GestureDetector(
                              onTap: () {

                                indexChecker(index);
                                // log('===== current match color is ${tmo.matchColorIndex.value} =====');
                                //
                                //
                                // tmo.matchColorIndex.value == index ?
                                //
                                //     tmo.showSelected.value = true
                                //
                                // : tmo.showSelected.value = false;
                                _carouselController.animateToPage(index);
//                                 // tmo.isSelectColor.value = true;
//                                 // tmo.isSelectColor.value = index;
//                                 // final contentSize = controler.position.viewportDimension + controler.position.maxScrollExtent;
//                                 // controler.animateTo(  (contentSize * index / colorList.length), duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
//                                 // controler.animateTo(  tmo.isSelectColor.value > 3 ? 200 : -200, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
//                                 // tmo.updateSelectedColorIndex(index);
//                                 print(tmo.currentSelectedArea);
//                                 // tmo.currentSelectedColorToggle(colorList[index]);
//                                 try {
//                                   if (tmo.lookname.value == "myselection") {
//                                     print('this is 1');
//                                     selectedcontroller.selectedProduct!.items![tmo.currentSelectedArea.value]
//                                         .shadeColour = colorList[index];
//                                   } else if (tmo.lookname.value == "m16") {
//                                     print('this is 2');
//
//
// //                             String val = tmo.currentSelectedProductsku.value;
// //                             final contain = tmo.selectedProducts.indexWhere((ele) => ele.hex==val);
// //                             if(contain< 0){
// //  int ind=0;
// // tmo.centralcolorleftmost.forEach((element) {
// //   if(element.faceSubArea==tmo.currentSelectedfacesubarea.value){
// //    ind= tmo.centralcolorleftmost.indexOf(element);
// //   }
// // });
//
// //  int sku_index=0;
//
// //  tmo.centralcolorleftmost[ind].faceSubareaLeftmostListOfProducts!.forEach((element)  {
// //  if(element.sku==tmo.currentSelectedProductsku.value)
// //  {
// //   sku_index=tmo.centralcolorleftmost[ind].faceSubareaLeftmostListOfProducts!.indexOf(element);
// //  }
// //  }
// //  );
// //   print( tmo.centralcolorleftmost[ind].faceSubareaLeftmostListOfProducts![sku_index].faceColor);
//
// //   tmo.centralcolorleftmost[ind].faceSubareaLeftmostListOfProducts![sku_index].faceColor=colorList[index];
// //   print( tmo.centralcolorleftmost[ind].faceSubareaLeftmostListOfProducts![sku_index].faceColor);
//                                     tmo.selectedProducts.add({
//                                       "customer_id": "160",
//                                       "face_subarea": tmo.currentSelectedfacesubarea.value,
//                                       "hex": colorList[index],
//                                       "sku": tmo.currentSelectedProductsku.value
//                                     });
//                                     print("dataaa " + jsonEncode(tmo.selectedProducts));
//                                   } else {
//                                     print('this is 3');
//
//                                     lookcontroller.ms8model!.itemData![tmo.currentSelectedArea.value]
//                                         .recommendedColor = colorList[index];
//                                     print(lookcontroller.ms8model!.itemData![0].recommendedColor);
//                                   }
//                                 } catch (er) {
//                                   print(er);
//                                 }
                              },
                              child: Column(
                                children: [

                                  tmo.currentSelectedColor.value == colorList[index] ? Text('MATCH',

                                    style: Theme.of(context).textTheme.headline2!.copyWith(
                                      color: Colors.black,
                                      fontSize: size.height * 0.011,
                                      letterSpacing: 0,
                                    ),
                                  )
                                  // )
                                      :  SizedBox(
                                    height: size.height * 0.013,
                                    width: size.width/ 7.05,
                                  ),


                                  Container(
                                    height: size.height * 0.06,
                                    width: size.height * 0.06,
                                    decoration: BoxDecoration(
                                      color: HexColor(colorList[index]),
                                      border:
                                      tmo.currentSelectedColor.value == colorList[index] ?  Border.all(
                                          width:  2,
                                          color: Colors.pink
                                      ) :
                                      Border.all(
                                        // width: tmo.isSelectColorIndex.value == index ? 2 : 0,
                                        //      color: tmo.isSelectColorIndex.value == index ? Colors.black : Colors.white
                                          width:  .1,
                                          color: Colors.white
                                      )
                                      ,
                                    ),
                                  ),
                                ],
                              ),
                            );
                            }
                          )
                      ),
                      // tmo.isSelectColorIndex.value ==  returnIndexIfAvailable() || tmo.currentSelectedColor.value == colorList[tmo.isSelectColorIndex.value > colorList.length ? 0 : tmo.isSelectColorIndex.value]
                      //     tmo.showSelected.value == false
                      tmo.matchColorIndex.value == tmo.outerIndex.value
                              ?
                          const SizedBox()  :   Container(
                        child:
                        Column(
                          children: [

                            Text('SELECTED',
                              style: Theme.of(context).textTheme.headline2!.copyWith(
                                color: Colors.black,
                                fontSize: size.height * 0.011,
                                letterSpacing: 0,
                              ),
                            ),
                            Container(
                              height: size.height * 0.06,
                              width: size.height * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  width:  2,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      : Container(
                      height: size.height * 0.05 - 8,
                      alignment: Alignment.center,
                      child: Text(
                        "No Colors",
                        style: TextStyle(fontSize: 10, decoration: TextDecoration.none, color: Colors.black),
                        textAlign: TextAlign.center,
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    _carouselController.nextPage();

   },
                  child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,  size: 16),
                ),
              ],
            ),
          ),
        );

      // : Container();
    });
  }
}