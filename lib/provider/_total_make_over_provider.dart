// import 'dart:isolate';
// import 'package:flutter_isolate/flutter_isolate.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sofiqe/utils/api/make_over_api.dart';
// import 'package:sofiqe/utils/api/total_make_over_product_api.dart';
// import 'package:sofiqe/utils/states/local_storage.dart';

// String token = '';
// int uid = -1;

// class TotalMakeOverProvider extends GetxController {
//   Function shareCallback = () {};
//   RxBool colorsAreReady = false.obs;
//   RxBool bottomSheetVisible = false.obs;
//   RxBool searchMenuVisible = false.obs;
//   RxBool searchOptionsVisible = false.obs;
//   RxInt currentSelectedArea = 0.obs;
//   RxInt colorMenuVisible = 0.obs;
//   Rx<FaceArea> faceArea = FaceArea.CHEEKS.obs;
//   RxList<ApplicationArea> applicationAreaList = <ApplicationArea>[].obs;
//   RxMap<int, List<dynamic>> productMap = {
//     5685: [],
//     5686: [],
//     5687: [],
//     5688: [],
//     5689: [],
//     5690: [],
//     5691: [],
//     5692: [],
//     5693: [],
//     5694: [],
//     5696: [],
//     5697: [],
//   }.obs;

//   RxMap<int, int> indexMap = {
//     5685: 0,
//     5686: 0,
//     5687: 0,
//     5688: 0,
//     5689: 0,
//     5690: 0,
//     5691: 0,
//     5692: 0,
//     5693: 0,
//     5694: 0,
//     5696: 0,
//     5697: 0,
//   }.obs;

//   RxMap centralColorMap = {}.obs;

//   RxMap<dynamic, dynamic> nonRecommendedColours = {
//     'total': -1.toInt(),
//     'color': <Color>[],
//     'remaining-pages': -1.toInt(),
//   }.obs;

//   TotalMakeOverProvider() {
//     initializeApplicationAreas();

//     applicationAreaList.value = faceApplicationMap[FaceArea.CHEEKS];
//     colorsAreReady.value = true;
//   }

//   Future<void> fetchNonRecommendedColours({int page = -1}) async {
//     if (page == -1) {
//       nonRecommendedColours = {
//         'total': -1,
//         'color': <Color>[],
//         'remaining-pages': -1,
//       }.obs;
//     }
//     Map result = await sfAPIGetNonRecommendedColours(page);
//     nonRecommendedColours['total'] = result['values']['total'];
//     nonRecommendedColours.value['color'] = <Color>[
//       ...nonRecommendedColours['color'],
//       ...result['values']['alt'].map(
//         (c) {
//           String hexString = c['color'];
//           final buffer = StringBuffer();
//           if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//           buffer.write(hexString.replaceFirst('#', ''));
//           return Color(int.parse(buffer.toString(), radix: 16));
//         },
//       ).toList()
//     ];
//     if (nonRecommendedColours['remaining-pages'] < 0) {
//       nonRecommendedColours['remaining-pages'] = nonRecommendedColours['total'] / result['values']['alt'].length;
//     }
//     if (nonRecommendedColours['remaining-pages'] > 1) {
//       nonRecommendedColours['remaining-pages'] -= 1;
//       fetchNonRecommendedColours(page: nonRecommendedColours['remaining-pages'].toInt());
//     }
//   }

//   // Future<void> fetchRecommendedColours() async {
//   //   Map result = await sfAPIGetRecommendedColours();
//   //   setRecommendedColours(result);
//   // }

//   void setRecommendedColours(Map result) async {
//     List colorsForEachArea = result['values']['colors'];

//     faceApplicationMap[FaceArea.CHEEKS][0].recommendedColors = colorsForEachArea[0]['color'];
//     faceApplicationMap[FaceArea.CHEEKS][1].recommendedColors = colorsForEachArea[1]['color'];
//     faceApplicationMap[FaceArea.CHEEKS][2].recommendedColors = colorsForEachArea[2]['color'];
//     faceApplicationMap[FaceArea.CHEEKS][3].recommendedColors = colorsForEachArea[3]['color'];
//     faceApplicationMap[FaceArea.EYES][0].recommendedColors = colorsForEachArea[4]['color'];
//     faceApplicationMap[FaceArea.EYES][1].recommendedColors = colorsForEachArea[5]['color'];
//     faceApplicationMap[FaceArea.EYES][2].recommendedColors = colorsForEachArea[6]['color'];
//     faceApplicationMap[FaceArea.EYES][3].recommendedColors = colorsForEachArea[7]['color'];
//     faceApplicationMap[FaceArea.EYES][4].recommendedColors = colorsForEachArea[8]['color'];
//     faceApplicationMap[FaceArea.LIPS][1].recommendedColors = colorsForEachArea[9]['color'];
//     faceApplicationMap[FaceArea.LIPS][0].recommendedColors = colorsForEachArea[10]['color'];
//     faceApplicationMap[FaceArea.CHEEKS][4].recommendedColors = colorsForEachArea[11]['color'];
//     colorsAreReady.value = true;
//   }

//   void getRecommendationsForLips() {
//     faceApplicationMap[faceArea.value] = applicationAreaList.value;
//     faceArea.value = FaceArea.LIPS;
//     applicationAreaList.value = faceApplicationMap[faceArea.value];
//     currentSelectedArea.value = 0;
//     searchOptionsVisible.value = false;
//   }

//   void getRecommendationsForCheeks() {
//     faceApplicationMap[faceArea.value] = applicationAreaList.value;

//     faceArea.value = FaceArea.CHEEKS;
//     applicationAreaList.value = faceApplicationMap[faceArea.value];
//     currentSelectedArea.value = 0;
//     searchOptionsVisible.value = false;
//   }

//   void getRecommendationsForEyes() {
//     faceApplicationMap[faceArea.value] = applicationAreaList.value;

//     faceArea.value = FaceArea.EYES;
//     applicationAreaList.value = faceApplicationMap[faceArea.value];
//     currentSelectedArea.value = 0;
//     searchOptionsVisible.value = false;
//     // applicationAreaList.forEach(
//     //   (ApplicationArea a) async {
//     //     if (a.ready) {
//     //       return;
//     //     } else {
//     //       print('fetching products for eyes');

//     //       a.ready = true;
//     //       a.products = await sfAPIGetRecommendedProductsByApplicationArea(
//     //           '${a.recommendedColors[a.recommendedColors.length - 1][0]}', '${faceAreaCode[FaceArea.EYES]}', '${a.code}');
//     //       // productMap[a.code] = a.products;
//     //       a.extractColours();
//     //       a.extractBrands();

//     //       centralColorMap[a.code] = '${a.recommendedColors[a.recommendedColors.length - 1][0]}';
//     //     }
//     //   },
//     // );
//   }

//   Future<void> fetchNewColor(List color) async {
//     for (ApplicationArea a in applicationAreaList) {
//       if (a.code == currentSelectedArea.value) {
//         productMap[a.code] = a.products[color];
//         // a.products = await sfAPIGetRecommendedProductsByApplicationArea(color, '${faceAreaCode[faceArea]}', '${a.code}');
//         // productMap[a.code] = a.products;
//         a.extractColours();
//         a.extractBrands();
//       }
//     }
//   }

//   void changeCentralColorFor(int code, List<dynamic> color) async {
//     // await fetchNewColor(color);
//     for (ApplicationArea a in applicationAreaList) {
//       if (a.code == currentSelectedArea.value) {
//         print(a.products.keys.toList()[0].runtimeType);
//         a.products.forEach((key, value) {
//           if (listEquals(key, color)) {
//             productMap[a.code] = value;
//             a.extractColours();
//             a.extractBrands();
//           }
//         });
//       }
//     }
//     centralColorMap[code] = color;
//   }

//   void currentSelectedAreaToggle(int code) {
//     if (currentSelectedArea.value == code) {
//       currentSelectedArea.value = 0;
//       searchMenuVisible.value = false;
//       searchOptionsVisible.value = false;
//     } else {
//       currentSelectedArea.value = code;
//     }
//   }

//   void toggleColorMenu(int code) {
//     if (colorMenuVisible.value == code) {
//       colorMenuVisible.value = 0;
//     } else {
//       colorMenuVisible.value = code;
//     }
//   }

//   void toggleSearch() {
//     searchOptionsVisible.value = !searchOptionsVisible.value;
//   }

//   void closeBottomSheet() {
//     bottomSheetVisible.value = false;
//     colorMenuVisible.value = 0;
//     searchMenuVisible.value = false;
//     searchOptionsVisible.value = false;
//     currentSelectedArea.value = 0;
//   }

//   void openBottomSheet() {
//     bottomSheetVisible.value = true;
//   }

//   Map faceAreaCode = {
//     FaceArea.LIPS: 5683,
//     FaceArea.CHEEKS: 5682,
//     FaceArea.EYES: 5681,
//   };

//   Future<void> initializeApplicationAreas() async {
//     ApplicationArea lipstick = ApplicationArea(name: 'lipstick', id: 11, subOf: FaceArea.LIPS, priority: 1, code: 5697);
//     ApplicationArea linersAndPencils = ApplicationArea(name: 'liners and pencils', id: 10, subOf: FaceArea.LIPS, priority: 2, code: 5696);
//     faceApplicationMap[FaceArea.LIPS] = [
//       lipstick,
//       linersAndPencils,
//     ];

//     ApplicationArea foundation = ApplicationArea(name: 'foundation', id: 1, subOf: FaceArea.CHEEKS, priority: 1, code: 5685);
//     ApplicationArea contourBronzer = ApplicationArea(name: 'bronzer', id: 2, subOf: FaceArea.CHEEKS, priority: 2, code: 5686);
//     ApplicationArea highlighter = ApplicationArea(name: 'highlight', id: 3, subOf: FaceArea.CHEEKS, priority: 3, code: 5687);
//     ApplicationArea blusher = ApplicationArea(name: 'blusher', id: 4, subOf: FaceArea.CHEEKS, priority: 4, code: 5688);
//     ApplicationArea concealer = ApplicationArea(name: 'concealer', id: 12, subOf: FaceArea.CHEEKS, priority: 5, code: 5689);

//     faceApplicationMap[FaceArea.CHEEKS] = [
//       foundation,
//       contourBronzer,
//       highlighter,
//       blusher,
//       concealer,
//     ];

//     ApplicationArea eyelid = ApplicationArea(name: 'eyelid', id: 5, subOf: FaceArea.EYES, priority: 1, code: 5690);
//     ApplicationArea eyeSocket = ApplicationArea(name: 'eye socket', id: 6, subOf: FaceArea.EYES, priority: 1, code: 5691);
//     ApplicationArea orbitalBone = ApplicationArea(name: 'orbital bone', id: 7, subOf: FaceArea.EYES, priority: 1, code: 5692);
//     ApplicationArea eyeliner = ApplicationArea(name: 'eyeliner', id: 8, subOf: FaceArea.EYES, priority: 1, code: 5693);
//     ApplicationArea eyebrowBrow = ApplicationArea(name: 'eyebrow', id: 9, subOf: FaceArea.EYES, priority: 1, code: 5694);
//     faceApplicationMap[FaceArea.EYES] = [
//       eyelid,
//       eyeSocket,
//       orbitalBone,
//       eyeliner,
//       eyebrowBrow,
//     ];

//     ReceivePort rp = ReceivePort();
//     FlutterIsolate worker = await FlutterIsolate.spawn(isolatedWorker, rp.sendPort);
//     rp.listen(messageHandler);
//   }

//   void messageHandler(data) async {
//     print(data);
//     switch (data['name']) {
//       case DataName.RECOMMENDEDCOLORS:
//         setRecommendedColours(data['data']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSFOUNDATION:
//         setFoundation(data['data'], data['index']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSCONTOUR:
//         setContour(data['data'], data['index']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSHIGHLIGHTER:
//         setHighlighter(data['data'], data['index']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSBLUSHER:
//         setBlusher(data['data'], data['index']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSEYELID:
//         setEyelid(data['data'], data['index']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSEYESOCKET:
//         setEyesocket(data['data'], data['index']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSORBITALBONE:
//         setOrbitalbone(data['data'], data['index']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSEYELINER:
//         setEyeliner(data['data'], data['index']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSEYEBROW:
//         setEyebrow(data['data'], data['index']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSLINERSANDPENCILS:
//         setLinersandpencils(data['data'], data['index']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSLIPSTICK:
//         setLipstick(data['data'], data['index']);
//         break;
//       case DataName.RECOMMENDEDPRODUCTSCONCEALER:
//         setConcealer(data['data'], data['index']);
//         break;
//     }
//   }

//   void setFoundation(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.CHEEKS][0];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   void setContour(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.CHEEKS][1];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   void setHighlighter(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.CHEEKS][2];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   void setBlusher(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.CHEEKS][3];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   void setEyelid(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.EYES][0];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   void setEyesocket(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.EYES][1];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   void setOrbitalbone(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.EYES][2];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   void setEyeliner(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.EYES][3];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   void setEyebrow(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.EYES][4];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   void setLinersandpencils(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.LIPS][1];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   void setLipstick(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.LIPS][0];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   void setConcealer(products, key) {
//     ApplicationArea a = faceApplicationMap[FaceArea.CHEEKS][4];
//     a.ready = true;
//     a.products[key] = products;

//     productMap[a.code] = a.products[key];
//     a.extractColours();
//     a.extractBrands();
//     centralColorMap.value[a.code] = a.recommendedColors[0];
//   }

//   Map faceApplicationMap = {
//     FaceArea.LIPS: [],
//     FaceArea.CHEEKS: [],
//     FaceArea.EYES: [],
//   };
// }

// class ApplicationArea {
//   late bool ready = false;
//   late String name;
//   late int id;
//   late FaceArea subOf;
//   late int priority;
//   late int code;
//   late int index;
//   late Map products = {};
//   late Map colors = {};
//   late List recommendedColors = [];
//   late List brands = [];
//   ApplicationArea({
//     required this.name,
//     required this.id,
//     required this.subOf,
//     required this.priority,
//     required this.code,
//   });

//   void extractBrands() {
//     print('extracting');
//   }

//   void extractColours() {
//     colors.clear();
//     products.forEach(
//       (key, value) {
//         if (value.isEmpty) {
//           return;
//         }
//         List c = [];
//         value.forEach(
//           (item) {
//             item['custom_attributes'].forEach(
//               (attr) {
//                 if (attr.containsKey('attribute_code')) {
//                   if (attr['attribute_code'] == 'face_color') {
//                     String colorString = attr['value'];
//                     final buffer = StringBuffer();
//                     if (colorString.length == 6 || colorString.length == 7) buffer.write('ff');
//                     buffer.write(colorString.replaceFirst('#', ''));
//                     // colors.add(Color(int.parse(buffer.toString(), radix: 16)));
//                     c.add(Color(int.parse(buffer.toString(), radix: 16)));
//                     // (colors[key] as List).add(Color(int.parse(buffer.toString(), radix: 16)));
//                   }
//                 }
//               },
//             );
//           },
//         );
//         colors[key] = c;
//       },
//     );
//   }
// }

// enum FaceArea {
//   LIPS,
//   CHEEKS,
//   EYES,
// }

// enum DataName {
//   RECOMMENDEDCOLORS,
//   RECOMMENDEDCOLORSFOUNDATION,
//   RECOMMENDEDCOLORSBRONZER,
//   RECOMMENDEDCOLORSHIGHLIGHTER,
//   RECOMMENDEDCOLORSBLUSHER,
//   RECOMMENDEDCOLORSCONCEALER,
//   RECOMMENDEDCOLORSEYELID,
//   RECOMMENDEDCOLORSEYESOCKET,
//   RECOMMENDEDCOLORSORBITALBONE,
//   RECOMMENDEDCOLORSEYELINER,
//   RECOMMENDEDCOLORSEYEBROW,
//   RECOMMENDEDCOLORSLINERSANDPENCILS,
//   RECOMMENDEDCOLORSLIPSTICK,

//   RECOMMENDEDPRODUCTSFOUNDATION,
//   RECOMMENDEDPRODUCTSCONTOUR,
//   RECOMMENDEDPRODUCTSHIGHLIGHTER,
//   RECOMMENDEDPRODUCTSBLUSHER,
//   RECOMMENDEDPRODUCTSEYELID,
//   RECOMMENDEDPRODUCTSEYESOCKET,
//   RECOMMENDEDPRODUCTSORBITALBONE,
//   RECOMMENDEDPRODUCTSEYELINER,
//   RECOMMENDEDPRODUCTSEYEBROW,
//   RECOMMENDEDPRODUCTSLINERSANDPENCILS,
//   RECOMMENDEDPRODUCTSLIPSTICK,
//   RECOMMENDEDPRODUCTSCONCEALER,
// }

// void isolatedWorker(SendPort sp) async {
//   Map<String, dynamic> uidMap = await sfQueryForSharedPrefData(fieldName: 'uid', type: PreferencesDataType.INT);
//   int uid = uidMap['uid'];

//   Map<String, dynamic> tokenMap = await sfQueryForSharedPrefData(fieldName: 'user-token', type: PreferencesDataType.STRING);
//   String token = tokenMap['user-token'];

//   // Foundation
//   Map resultRecommendedColorsFoundation = await sfAPIGetRecommendedColours(uid, token, 'Foundation');
//   sp.send({
//     'data': resultRecommendedColorsFoundation,
//     'name': DataName.RECOMMENDEDCOLORSFOUNDATION,
//   });

//   List recommendedColorsFoundation = resultRecommendedColorsFoundation['values']['colors']; // Used to fetch all central colour products
//   recommendedColorsFoundation[0]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsFoundation = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5685');
//       sp.send(
//         {
//           'data': resultRecommendedProductsFoundation,
//           'name': DataName.RECOMMENDEDPRODUCTSFOUNDATION,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended Colors and send
//   // Map resultRecommendedColors = await sfAPIGetRecommendedColours();
//   // sp.send(
//   //   {
//   //     'data': resultRecommendedColors,
//   //     'name': DataName.RECOMMENDEDCOLORS,
//   //   },
//   // );

//   // List recommendedColors = resultRecommendedColors['values']['colors']; // Used to fetch all central colour products
//   List recommendedColors = resultRecommendedColorsFoundation['values']['colors']; // Used to fetch all central colour products

//   // Fetch Recommended products for first central colour of foundation
//   recommendedColors[0]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsFoundation = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5685');
//       sp.send(
//         {
//           'data': resultRecommendedProductsFoundation,
//           'name': DataName.RECOMMENDEDPRODUCTSFOUNDATION,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended products for first central colour of Contour
//   recommendedColors[1]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsContour = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5686');
//       sp.send(
//         {
//           'data': resultRecommendedProductsContour,
//           'name': DataName.RECOMMENDEDPRODUCTSCONTOUR,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended products for first central colour of Highlighter
//   recommendedColors[2]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsHighlighter = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5687');
//       sp.send(
//         {
//           'data': resultRecommendedProductsHighlighter,
//           'name': DataName.RECOMMENDEDPRODUCTSHIGHLIGHTER,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended products for first central colour of Blusher
//   recommendedColors[3]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsBlusher = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5686');
//       sp.send(
//         {
//           'data': resultRecommendedProductsBlusher,
//           'name': DataName.RECOMMENDEDPRODUCTSBLUSHER,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended products for first central colour of Eyelid
//   recommendedColors[4]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsEyelid = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5681', '5690');
//       sp.send(
//         {
//           'data': resultRecommendedProductsEyelid,
//           'name': DataName.RECOMMENDEDPRODUCTSEYELID,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended products for first central colour of Eyesocket
//   recommendedColors[5]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsEyeSocket = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5691');
//       sp.send(
//         {
//           'data': resultRecommendedProductsEyeSocket,
//           'name': DataName.RECOMMENDEDPRODUCTSEYESOCKET,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended products for first central colour of Orbitalbone
//   recommendedColors[6]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsOrbitalbone = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5692');
//       sp.send(
//         {
//           'data': resultRecommendedProductsOrbitalbone,
//           'name': DataName.RECOMMENDEDPRODUCTSORBITALBONE,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended products for first central colour of Eyeliner
//   recommendedColors[7]['color'].add(['#ff0000', 'main']);
//   recommendedColors[7]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsEyeliner = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5693');
//       sp.send(
//         {
//           'data': resultRecommendedProductsEyeliner,
//           'name': DataName.RECOMMENDEDPRODUCTSEYELINER,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended products for first central colour of Eyebrow
//   recommendedColors[8]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsEyebrow = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5694');
//       sp.send(
//         {
//           'data': resultRecommendedProductsEyebrow,
//           'name': DataName.RECOMMENDEDPRODUCTSEYEBROW,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended products for first central colour of Linersandpencils
//   recommendedColors[9]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsLinersandpencils = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5696');
//       sp.send(
//         {
//           'data': resultRecommendedProductsLinersandpencils,
//           'name': DataName.RECOMMENDEDPRODUCTSLINERSANDPENCILS,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended products for first central colour of Lipstick
//   recommendedColors[10]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsLipstick = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5697');
//       sp.send(
//         {
//           'data': resultRecommendedProductsLipstick,
//           'name': DataName.RECOMMENDEDPRODUCTSLIPSTICK,
//           'index': c,
//         },
//       );
//     },
//   );

//   // Fetch Recommended products for first central colour of Concealer
//   recommendedColors[11]['color'].forEach(
//     (c) async {
//       List resultRecommendedProductsConcealer = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5689');
//       sp.send(
//         {
//           'data': resultRecommendedProductsConcealer,
//           'name': DataName.RECOMMENDEDPRODUCTSCONCEALER,
//           'index': c,
//         },
//       );
//     },
//   );
// }
