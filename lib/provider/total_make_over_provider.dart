// // ignore_for_file: invalid_use_of_protected_member, unused_local_variable

// import 'package:get/get.dart';
// import 'package:sofiqe/model/product_model.dart';
// import 'package:sofiqe/utils/api/make_over_api.dart';
// import 'package:sofiqe/utils/api/product_list_api.dart';
// import 'package:sofiqe/utils/states/local_storage.dart';

// class TotalMakeOverProvider extends GetxController {
//   Function shareCallback = () {};
//   RxBool colorsAreReady = false.obs;
//   RxBool bottomSheetVisible = false.obs;
//   RxBool searchMenuVisible = false.obs;
//   RxBool searchOptionsVisible = false.obs;
//   RxInt currentSelectedArea = 0.obs;
//   RxInt colorMenuVisible = 0.obs;
//   String undertone = '';
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
//     'color': <String>[],
//   }.obs;

//   TotalMakeOverProvider() {
//     initializeApplicationAreas();

//     applicationAreaList.value = faceApplicationMap[FaceArea.CHEEKS];
//   }

//   Future<void> fetchNonRecommendedColours() async {
//     nonRecommendedColours = {
//       'total': -1,
//       'color': <String>[],
//     }.obs;

//     String areaName = '';
//     this.applicationAreaList.forEach(
//       (aa) {
//         if (aa.code == this.currentSelectedArea.value) {
//           areaName = aa.name;
//         }
//       },
//     );
//     List result = await sfAPIGetNonRecommendedColours(areaName);
//     List colorList = result[0]['product'];

//     nonRecommendedColours['total'] = colorList.length;
//     nonRecommendedColours['color'] = colorList.map((c) {
//       return {
//         'hex': c['HEXcolour'],
//         'id': c['magentoID'],
//       };
//     }).toList();
//   }

//   void getRecommendationsForLips() {
//     faceApplicationMap[faceArea.value] = applicationAreaList.value;
//     colorMenuVisible.value = 0;
//     faceArea.value = FaceArea.LIPS;
//     applicationAreaList.value = faceApplicationMap[faceArea.value];
//     currentSelectedArea.value = 0;
//     searchOptionsVisible.value = false;
//   }

//   void getRecommendationsForCheeks() {
//     faceApplicationMap[faceArea.value] = applicationAreaList.value;
//     colorMenuVisible.value = 0;
//     faceArea.value = FaceArea.CHEEKS;
//     applicationAreaList.value = faceApplicationMap[faceArea.value];
//     currentSelectedArea.value = 0;
//     searchOptionsVisible.value = false;
//   }

//   void getRecommendationsForEyes() {
//     faceApplicationMap[faceArea.value] = applicationAreaList.value;
//     colorMenuVisible.value = 0;
//     faceArea.value = FaceArea.EYES;
//     applicationAreaList.value = faceApplicationMap[faceArea.value];
//     currentSelectedArea.value = 0;
//     searchOptionsVisible.value = false;
//   }

//   Future<void> fetchNewColor(List color) async {
//     for (ApplicationArea a in applicationAreaList) {
//       if (a.code == currentSelectedArea.value) {
//         productMap[a.code] = a.products[color];
//         a.extractColours();
//         a.extractBrands();
//       }
//     }
//   }

//   void changeCentralColorFor(int code, var color) async {
//     centralColorMap[code] = color;
//     this.applicationAreaList.forEach(
//       (aa) {
//         if (aa.code == this.currentSelectedArea.value) {
//           aa.selectedShade = aa.products[color['ColourAltHEX']][0].color;
//           aa.selectedBrand = 'ALL';
//         }
//       },
//     );
//   }

//   void changeToNonRecommendedColor(int code, Map colorWithId) async {
//     print(colorWithId);

//     Map<String, dynamic> uidMap = await sfQueryForSharedPrefData(
//         fieldName: 'uid', type: PreferencesDataType.INT);
//     int uid = uidMap['uid'];

//     Map<String, dynamic> tokenMap = await sfQueryForSharedPrefData(
//         fieldName: 'user-token', type: PreferencesDataType.STRING);
//     String token = tokenMap['user-token'];

//     Map result = await sfAPIGetNonRecommendedColourProducts(colorWithId['id']);
//     List items = result['items'];
//     this.applicationAreaList.forEach((aa) {
//       if (aa.code == code) {
//         print(items);
//         print(aa.code);
//         aa.addNonRecommendedProduct(items[0], colorWithId['hex']);
//       }
//     });
//     changeCentralColorFor(
//       code,
//       {
//         "ColourAltName": "",
//         "ColourAltHEX": colorWithId['hex'],
//       },
//     );
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
//     ApplicationArea lipstick = ApplicationArea(
//         name: 'lipstick',
//         id: 11,
//         subOf: FaceArea.LIPS,
//         priority: 1,
//         code: 5697);
//     ApplicationArea linersAndPencils = ApplicationArea(
//         name: 'liners and pencils',
//         id: 10,
//         subOf: FaceArea.LIPS,
//         priority: 2,
//         code: 5696);
//     faceApplicationMap[FaceArea.LIPS] = [
//       lipstick,
//       linersAndPencils,
//     ];

//     ApplicationArea foundation = ApplicationArea(
//         name: 'foundation',
//         id: 1,
//         subOf: FaceArea.CHEEKS,
//         priority: 1,
//         code: 5685);
//     ApplicationArea contourBronzer = ApplicationArea(
//         name: 'bronzer',
//         id: 2,
//         subOf: FaceArea.CHEEKS,
//         priority: 2,
//         code: 5686);
//     ApplicationArea highlighter = ApplicationArea(
//         name: 'highlight',
//         id: 3,
//         subOf: FaceArea.CHEEKS,
//         priority: 3,
//         code: 5687);
//     ApplicationArea blusher = ApplicationArea(
//         name: 'blusher',
//         id: 4,
//         subOf: FaceArea.CHEEKS,
//         priority: 4,
//         code: 5688);
//     ApplicationArea concealer = ApplicationArea(
//         name: 'concealer',
//         id: 12,
//         subOf: FaceArea.CHEEKS,
//         priority: 5,
//         code: 5689);

//     faceApplicationMap[FaceArea.CHEEKS] = [
//       foundation,
//       contourBronzer,
//       highlighter,
//       blusher,
//       concealer,
//     ];

//     ApplicationArea eyelid = ApplicationArea(
//         name: 'eyelid', id: 5, subOf: FaceArea.EYES, priority: 1, code: 5690);
//     ApplicationArea eyeSocket = ApplicationArea(
//         name: 'eye socket',
//         id: 6,
//         subOf: FaceArea.EYES,
//         priority: 1,
//         code: 5691);
//     ApplicationArea orbitalBone = ApplicationArea(
//         name: 'orbital bone',
//         id: 7,
//         subOf: FaceArea.EYES,
//         priority: 1,
//         code: 5692);
//     ApplicationArea eyeliner = ApplicationArea(
//         name: 'eyeliner', id: 8, subOf: FaceArea.EYES, priority: 1, code: 5693);
//     ApplicationArea eyebrowBrow = ApplicationArea(
//         name: 'eyebrow', id: 9, subOf: FaceArea.EYES, priority: 1, code: 5694);
//     faceApplicationMap[FaceArea.EYES] = [
//       eyelid,
//       eyeSocket,
//       orbitalBone,
//       eyeliner,
//       eyebrowBrow,
//     ];



//     await getRecommendedColors();
//   }

//   Future<void> getRecommendedColors() async {
//     Map<String, dynamic> uidMap = await sfQueryForSharedPrefData(
//         fieldName: 'uid', type: PreferencesDataType.INT);
//     int uid = uidMap['uid'] == null ? 0 : uidMap['uid'];

//     Map<String, dynamic> tokenMap = await sfQueryForSharedPrefData(
//         fieldName: 'user-token', type: PreferencesDataType.STRING);
//     String token = tokenMap['user-token'] == null ? '' : tokenMap['user-token'];

//     List resultFoundation =
//         await sfAPIGetRecommendedColours(uid, token, 'Foundation');
//     if(resultFoundation.isNotEmpty) {
//       faceApplicationMap[FaceArea.CHEEKS][0].recommendedColors =
//       resultFoundation[0]['values']['colors'];
//       undertone = resultFoundation[0]['values']['undertone'];
//       faceApplicationMap[FaceArea.CHEEKS][0].recommendedColors.forEach(
//             (c) async {
//           List resultFoundationProduct = await sfAPIFetchCentralColorProducts(
//               token, c['ColourAltHEX'], undertone, 'Foundation', 5);
//           faceApplicationMap[FaceArea.CHEEKS][0]
//               .addProducts(resultFoundationProduct, c['ColourAltHEX']);
//         },
//       );
//       centralColorMap[faceApplicationMap[FaceArea.CHEEKS][0].code] =
//       faceApplicationMap[FaceArea.CHEEKS][0].recommendedColors[0];
//     }

//     List resultBronzer =
//         await sfAPIGetRecommendedColours(uid, token, 'Bronzer');
//     if(resultBronzer.isNotEmpty) {
//       faceApplicationMap[FaceArea.CHEEKS][1].recommendedColors =
//       resultBronzer[0]['values']['colors'];
//       faceApplicationMap[FaceArea.CHEEKS][1].recommendedColors.forEach(
//             (c) async {
//           List resultBronzerProduct = await sfAPIFetchCentralColorProducts(
//               token, c['ColourAltHEX'], undertone, 'Bronzer', 5);
//           faceApplicationMap[FaceArea.CHEEKS][1]
//               .addProducts(resultBronzerProduct, c['ColourAltHEX']);
//         },
//       );
//       centralColorMap[faceApplicationMap[FaceArea.CHEEKS][1].code] =
//       faceApplicationMap[FaceArea.CHEEKS][1].recommendedColors[0];
//     }

//     List resultHighlighter =
//         await sfAPIGetRecommendedColours(uid, token, 'Highligther');
//     if(resultHighlighter.isNotEmpty) {
//       faceApplicationMap[FaceArea.CHEEKS][2].recommendedColors =
//       resultHighlighter[0]['values']['colors'];
//       faceApplicationMap[FaceArea.CHEEKS][2].recommendedColors.forEach(
//             (c) async {
//           List resultHighlighterProduct = await sfAPIFetchCentralColorProducts(
//               token, c['ColourAltHEX'], undertone, 'Highligther', 5);
//           faceApplicationMap[FaceArea.CHEEKS][2]
//               .addProducts(resultHighlighterProduct, c['ColourAltHEX']);
//         },
//       );
//       centralColorMap[faceApplicationMap[FaceArea.CHEEKS][2].code] =
//       faceApplicationMap[FaceArea.CHEEKS][2].recommendedColors[0];
//     }

//     List resultBlusher =
//         await sfAPIGetRecommendedColours(uid, token, 'Blusher');

//     if(resultBlusher.isNotEmpty) {
//       faceApplicationMap[FaceArea.CHEEKS][3].recommendedColors =
//       resultBlusher[0]['values']['colors'];
//       centralColorMap.value[faceApplicationMap[FaceArea.CHEEKS][3].code] =
//       faceApplicationMap[FaceArea.CHEEKS][3].recommendedColors[0];
//       faceApplicationMap[FaceArea.CHEEKS][3].recommendedColors.forEach(
//             (c) async {
//           List resultBlusherProduct = await sfAPIFetchCentralColorProducts(
//               token, c['ColourAltHEX'], undertone, 'Blusher', 5);
//           faceApplicationMap[FaceArea.CHEEKS][3]
//               .addProducts(resultBlusherProduct, c['ColourAltHEX']);
//         },
//       );
//     }

//     List resultConcealer =
//         await sfAPIGetRecommendedColours(uid, token, 'Consealer');
//     if(resultConcealer.isNotEmpty) {
//       faceApplicationMap[FaceArea.CHEEKS][4].recommendedColors =
//       resultConcealer[0]['values']['colors'];
//       centralColorMap.value[faceApplicationMap[FaceArea.CHEEKS][4].code] =
//       faceApplicationMap[FaceArea.CHEEKS][4].recommendedColors[0];
//       faceApplicationMap[FaceArea.CHEEKS][4].recommendedColors.forEach(
//             (c) async {
//           List resultConcealerProduct = await sfAPIFetchCentralColorProducts(
//               token, c['ColourAltHEX'], undertone, 'Consealer', 5);
//           faceApplicationMap[FaceArea.CHEEKS][4]
//               .addProducts(resultConcealerProduct, c['ColourAltHEX']);
//         },
//       );
//     }

//     List resultEyelid = await sfAPIGetRecommendedColours(uid, token, 'Eyelid');
//     if(resultEyelid.isNotEmpty) {
//       try {
//         faceApplicationMap[FaceArea.EYES][0].recommendedColors =
//         resultEyelid[0]['values']['colors'];
//         centralColorMap.value[faceApplicationMap[FaceArea.EYES][0].code] =
//         faceApplicationMap[FaceArea.EYES][0].recommendedColors[0];
//         faceApplicationMap[FaceArea.EYES][0].recommendedColors.forEach(
//               (c) async {
//             List resultEyelidProduct = await sfAPIFetchCentralColorProducts(
//                 token, c['ColourAltHEX'], undertone, 'Eyelid', 5);
//             faceApplicationMap[FaceArea.EYES][0]
//                 .addProducts(resultEyelidProduct, c['ColourAltHEX']);
//           },
//         );
//       }catch(e){

//       }
//     }

//     List resultEyesocket =
//         await sfAPIGetRecommendedColours(uid, token, 'Eyesocket');
//     if(resultEyesocket.isNotEmpty) {
//       try {
//         faceApplicationMap[FaceArea.EYES][1].recommendedColors =
//         resultEyesocket[0]['values']['colors'];
//         centralColorMap.value[faceApplicationMap[FaceArea.EYES][1].code] =
//         faceApplicationMap[FaceArea.EYES][1].recommendedColors[0];
//         faceApplicationMap[FaceArea.EYES][1].recommendedColors.forEach(
//               (c) async {
//             List resultEyesocketProduct = await sfAPIFetchCentralColorProducts(
//                 token, c['ColourAltHEX'], undertone, 'Eyesocket', 5);
//             faceApplicationMap[FaceArea.EYES][1]
//                 .addProducts(resultEyesocketProduct, c['ColourAltHEX']);
//           },
//         );
//       }catch(e){

//       }
//     }

//     List resultOrbitalbone =
//         await sfAPIGetRecommendedColours(uid, token, 'Orbital-bone');
//     if(resultOrbitalbone.isNotEmpty) {
//       try {
//         faceApplicationMap[FaceArea.EYES][2].recommendedColors =
//         resultOrbitalbone[0]['values']['colors'];
//         centralColorMap.value[faceApplicationMap[FaceArea.EYES][2].code] =
//         faceApplicationMap[FaceArea.EYES][2].recommendedColors[0];
//         faceApplicationMap[FaceArea.EYES][2].recommendedColors.forEach(
//               (c) async {
//             List resultOrbitalboneProduct = await sfAPIFetchCentralColorProducts(
//                 token, c['ColourAltHEX'], undertone, 'Orbital-bone', 5);
//             faceApplicationMap[FaceArea.EYES][2]
//                 .addProducts(resultOrbitalboneProduct, c['ColourAltHEX']);
//           },
//         );
//       }catch(e){

//       }
//     }

//     List resultEyeliner =
//         await sfAPIGetRecommendedColours(uid, token, 'Eyeliner');
//     if(resultEyeliner.isNotEmpty) {
//       faceApplicationMap[FaceArea.EYES][3].recommendedColors =
//       resultEyeliner[0]['values']['colors'];
//       centralColorMap.value[faceApplicationMap[FaceArea.EYES][3].code] =
//       faceApplicationMap[FaceArea.EYES][3].recommendedColors[0];
//       faceApplicationMap[FaceArea.EYES][3].recommendedColors.forEach(
//             (c) async {
//           List resultEyelinerProduct = await sfAPIFetchCentralColorProducts(
//               token, c['ColourAltHEX'], undertone, 'Eyeliner', 5);
//           faceApplicationMap[FaceArea.EYES][3]
//               .addProducts(resultEyelinerProduct, c['ColourAltHEX']);
//         },
//       );
//     }

//     // Find the correct keyword
//     List resultEyebrow =
//         await sfAPIGetRecommendedColours(uid, token, 'Eyeliner');
//     if(resultEyebrow.isNotEmpty) {
//       faceApplicationMap[FaceArea.EYES][4].recommendedColors =
//       resultEyebrow[0]['values']['colors'];
//       centralColorMap.value[faceApplicationMap[FaceArea.EYES][4].code] =
//       faceApplicationMap[FaceArea.EYES][4].recommendedColors[0];
//       faceApplicationMap[FaceArea.EYES][4].recommendedColors.forEach(
//             (c) async {
//           List resultEyebrowProduct = await sfAPIFetchCentralColorProducts(
//               token, c['ColourAltHEX'], undertone, 'Eyeliner', 5);
//           faceApplicationMap[FaceArea.EYES][4]
//               .addProducts(resultEyebrowProduct, c['ColourAltHEX']);
//         },
//       );
//     }

//     // Find the correct keyword
//     List resultLipstick =
//         await sfAPIGetRecommendedColours(uid, token, 'lipliner');
//     if(resultLipstick.isNotEmpty) {
//       faceApplicationMap[FaceArea.LIPS][0].recommendedColors =
//       resultLipstick[0]['values']['colors'];
//       centralColorMap.value[faceApplicationMap[FaceArea.LIPS][0].code] =
//       faceApplicationMap[FaceArea.LIPS][0].recommendedColors[0];
//       faceApplicationMap[FaceArea.LIPS][0].recommendedColors.forEach(
//             (c) async {
//           List resultLipstickProduct = await sfAPIFetchCentralColorProducts(
//               token, c['ColourAltHEX'], undertone, 'lipliner', 5);
//           faceApplicationMap[FaceArea.LIPS][0]
//               .addProducts(resultLipstickProduct, c['ColourAltHEX']);
//         },
//       );
//     }

//     List resultLiner = await sfAPIGetRecommendedColours(uid, token, 'lipliner');
//     if(resultLiner.isNotEmpty) {
//       faceApplicationMap[FaceArea.LIPS][1].recommendedColors =
//       resultLiner[0]['values']['colors'];
//       centralColorMap.value[faceApplicationMap[FaceArea.LIPS][1].code] =
//       faceApplicationMap[FaceArea.LIPS][1].recommendedColors[0];
//       faceApplicationMap[FaceArea.LIPS][1].recommendedColors.forEach(
//             (c) async {
//           List resultLinerProduct = await sfAPIFetchCentralColorProducts(
//               token, c['ColourAltHEX'], undertone, 'lipliner', 5);
//           faceApplicationMap[FaceArea.LIPS][1]
//               .addProducts(resultLinerProduct, c['ColourAltHEX']);
//         },
//       );
//     }

//     this.colorsAreReady.value = true;
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
//   late String selectedShade = '#ffffff';
//   late String selectedBrand = 'ALL';
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

//   void addProducts(List output, String colorHex) {
//     //products['$colorHex'] = <Product>[];
//     //Map resultMap = output[0];
//     // resultMap['product'].forEach(
//     //   (key, value) { &
//     //     products['$colorHex'].add(Product.fromMap(value));
//     //   },
//     // );
//     // selectedShade = products['$colorHex'][0].color;
//   }

//   void addNonRecommendedProduct(Map product, String colorHex) {
//     products['$colorHex'] = <Product>[];
//     products['$colorHex'].add(Product.fromDefaultMap(product));
//     selectedShade = products['$colorHex'][0].color;
//   }

//   void extractColours() {
//     colors.clear();
//     products.forEach(
//       (key, value) {
//         if (value.isEmpty) {
//           return;
//         }
//         List c = [];
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


import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/utils/api/make_over_api.dart';
import 'package:sofiqe/utils/api/total_make_over_product_api.dart';

class TotalMakeOverProvider extends GetxController {
  Function shareCallback = () {};
  RxBool colorsAreReady = false.obs;
  RxBool bottomSheetVisible = false.obs;
  RxBool searchMenuVisible = false.obs;
  RxBool searchOptionsVisible = false.obs;
  RxInt currentSelectedArea = 0.obs;
  RxInt colorMenuVisible = 0.obs;
  Rx<FaceArea> faceArea = FaceArea.CHEEKS.obs;
  RxList<ApplicationArea> applicationAreaList = <ApplicationArea>[].obs;
  RxMap<int, List<dynamic>> productMap = {
    5685: [],
    5686: [],
    5687: [],
    5688: [],
    5689: [],
    5690: [],
    5691: [],
    5692: [],
    5693: [],
    5694: [],
    5696: [],
    5697: [],
  }.obs;

  RxMap<int, int> indexMap = {
    5685: 0,
    5686: 0,
    5687: 0,
    5688: 0,
    5689: 0,
    5690: 0,
    5691: 0,
    5692: 0,
    5693: 0,
    5694: 0,
    5696: 0,
    5697: 0,
  }.obs;

  RxMap centralColorMap = {}.obs;

  RxMap<dynamic, dynamic> nonRecommendedColours = {
    'total': -1.toInt(),
    'color': <Color>[],
    'remaining-pages': -1.toInt(),
  }.obs;

  TotalMakeOverProvider() {
    initializeApplicationAreas();

    applicationAreaList.value = faceApplicationMap[FaceArea.CHEEKS];
    colorsAreReady.value = true;
  }

  Future<void> fetchNonRecommendedColours({int page = -1}) async {
    if (page == -1) {
      nonRecommendedColours = {
        'total': -1,
        'color': <Color>[],
        'remaining-pages': -1,
      }.obs;
    }
    Map result = await sfAPIGetNonRecommendedColours(page);
    nonRecommendedColours['total'] = result['values']['total'];
    nonRecommendedColours['color'] = <Color>[
      ...nonRecommendedColours['color'],
      ...result['values']['alt'].map(
        (c) {
          String hexString = c['color'];
          final buffer = StringBuffer();
          if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
          buffer.write(hexString.replaceFirst('#', ''));
          return Color(int.parse(buffer.toString(), radix: 16));
        },
      ).toList()
    ];
    if (nonRecommendedColours['remaining-pages'] < 0) {
      nonRecommendedColours['remaining-pages'] = nonRecommendedColours['total'] / result['values']['alt'].length;
    }
    if (nonRecommendedColours['remaining-pages'] > 1) {
      nonRecommendedColours['remaining-pages'] -= 1;
      fetchNonRecommendedColours(page: nonRecommendedColours['remaining-pages'].toInt());
    }
  }

  Future<void> fetchRecommendedColours() async {
    Map result = await sfAPIGetRecommendedColours();
    setRecommendedColours(result);
  }

  void setRecommendedColours(Map result) async {
    List colorsForEachArea = result['values']['colors'];

    faceApplicationMap[FaceArea.CHEEKS][0].recommendedColors = colorsForEachArea[0]['color'];
    faceApplicationMap[FaceArea.CHEEKS][1].recommendedColors = colorsForEachArea[1]['color'];
    faceApplicationMap[FaceArea.CHEEKS][2].recommendedColors = colorsForEachArea[2]['color'];
    faceApplicationMap[FaceArea.CHEEKS][3].recommendedColors = colorsForEachArea[3]['color'];
    faceApplicationMap[FaceArea.EYES][0].recommendedColors = colorsForEachArea[4]['color'];
    faceApplicationMap[FaceArea.EYES][1].recommendedColors = colorsForEachArea[5]['color'];
    faceApplicationMap[FaceArea.EYES][2].recommendedColors = colorsForEachArea[6]['color'];
    faceApplicationMap[FaceArea.EYES][3].recommendedColors = colorsForEachArea[7]['color'];
    faceApplicationMap[FaceArea.EYES][3].recommendedColors.add(['#ff0000', 'main']);
    faceApplicationMap[FaceArea.EYES][4].recommendedColors = colorsForEachArea[8]['color'];
    faceApplicationMap[FaceArea.LIPS][1].recommendedColors = colorsForEachArea[9]['color'];
    faceApplicationMap[FaceArea.LIPS][0].recommendedColors = colorsForEachArea[10]['color'];
    faceApplicationMap[FaceArea.CHEEKS][4].recommendedColors = colorsForEachArea[11]['color'];
    colorsAreReady.value = true;
  }

  void getRecommendationsForLips() {
    faceApplicationMap[faceArea.value] = applicationAreaList;
    faceArea.value = FaceArea.LIPS;
    applicationAreaList.value = faceApplicationMap[faceArea.value];
    currentSelectedArea.value = 0;
    searchOptionsVisible.value = false;
  }

  void getRecommendationsForCheeks() {
    faceApplicationMap[faceArea.value] = applicationAreaList;

    faceArea.value = FaceArea.CHEEKS;
    applicationAreaList.value = faceApplicationMap[faceArea.value];
    currentSelectedArea.value = 0;
    searchOptionsVisible.value = false;
  }

  void getRecommendationsForEyes() {
    faceApplicationMap[faceArea.value] = applicationAreaList;

    faceArea.value = FaceArea.EYES;
    applicationAreaList.value = faceApplicationMap[faceArea.value];
    currentSelectedArea.value = 0;
    searchOptionsVisible.value = false;
    applicationAreaList.forEach(
      (ApplicationArea a) async {
        if (a.ready) {
          return;
        } else {
          print('fetching products for eyes');

          a.ready = true;
          a.products = await sfAPIGetRecommendedProductsByApplicationArea(
              '${a.recommendedColors[a.recommendedColors.length - 1][0]}', '${faceAreaCode[FaceArea.EYES]}', '${a.code}');
          // productMap[a.code] = a.products;
          a.extractColours();
          a.extractBrands();

          centralColorMap[a.code] = '${a.recommendedColors[a.recommendedColors.length - 1][0]}';
        }
      },
    );
  }

  Future<void> fetchNewColor(List color) async {
    for (ApplicationArea a in applicationAreaList) {
      if (a.code == currentSelectedArea.value) {
        productMap[a.code] = a.products[color];
        // a.products = await sfAPIGetRecommendedProductsByApplicationArea(color, '${faceAreaCode[faceArea]}', '${a.code}');
        // productMap[a.code] = a.products;
        a.extractColours();
        a.extractBrands();
      }
    }
  }

  void changeCentralColorFor(int code, List<dynamic> color) async {
    // await fetchNewColor(color);
    for (ApplicationArea a in applicationAreaList) {
      if (a.code == currentSelectedArea.value) {
        print(a.products.keys.toList()[0].runtimeType);
        a.products.forEach((key, value) {
          if (listEquals(key, color)) {
            productMap[a.code] = value;
            a.extractColours();
            a.extractBrands();
          }
        });
      }
    }
    centralColorMap[code] = color;
  }

  void currentSelectedAreaToggle(int code) {
    if (currentSelectedArea.value == code) {
      currentSelectedArea.value = 0;
      searchMenuVisible.value = false;
      searchOptionsVisible.value = false;
    } else {
      currentSelectedArea.value = code;
    }
  }

  void toggleColorMenu(int code) {
    if (colorMenuVisible.value == code) {
      colorMenuVisible.value = 0;
    } else {
      colorMenuVisible.value = code;
    }
  }

  void toggleSearch() {
    searchOptionsVisible.value = !searchOptionsVisible.value;
  }

  void closeBottomSheet() {
    bottomSheetVisible.value = false;
    colorMenuVisible.value = 0;
    searchMenuVisible.value = false;
    searchOptionsVisible.value = false;
    currentSelectedArea.value = 0;
  }

  void openBottomSheet() {
    bottomSheetVisible.value = true;
  }

  Map faceAreaCode = {
    FaceArea.LIPS: 5683,
    FaceArea.CHEEKS: 5682,
    FaceArea.EYES: 5681,
  };

  Future<void> initializeApplicationAreas() async {
    ApplicationArea lipstick = ApplicationArea(name: 'lipstick', id: 11, subOf: FaceArea.LIPS, priority: 1, code: 5697);
    ApplicationArea linersAndPencils = ApplicationArea(name: 'liners and pencils', id: 10, subOf: FaceArea.LIPS, priority: 2, code: 5696);
    faceApplicationMap[FaceArea.LIPS] = [
      lipstick,
      linersAndPencils,
    ];

    ApplicationArea foundation = ApplicationArea(name: 'foundation', id: 1, subOf: FaceArea.CHEEKS, priority: 1, code: 5685);
    ApplicationArea contourBronzer = ApplicationArea(name: 'contour/bronzer', id: 2, subOf: FaceArea.CHEEKS, priority: 2, code: 5686);
    ApplicationArea highlighter = ApplicationArea(name: 'highlighter', id: 3, subOf: FaceArea.CHEEKS, priority: 3, code: 5687);
    ApplicationArea blusher = ApplicationArea(name: 'blusher', id: 4, subOf: FaceArea.CHEEKS, priority: 4, code: 5688);
    ApplicationArea concealer = ApplicationArea(name: 'concealer', id: 12, subOf: FaceArea.CHEEKS, priority: 5, code: 5689);

    faceApplicationMap[FaceArea.CHEEKS] = [
      foundation,
      contourBronzer,
      highlighter,
      blusher,
      concealer,
    ];

    ApplicationArea eyelid = ApplicationArea(name: 'eyelid', id: 5, subOf: FaceArea.EYES, priority: 1, code: 5690);
    ApplicationArea eyeSocket = ApplicationArea(name: 'eye socket', id: 6, subOf: FaceArea.EYES, priority: 1, code: 5691);
    ApplicationArea orbitalBone = ApplicationArea(name: 'orbital bone', id: 7, subOf: FaceArea.EYES, priority: 1, code: 5692);
    ApplicationArea eyeliner = ApplicationArea(name: 'eyeliner', id: 8, subOf: FaceArea.EYES, priority: 1, code: 5693);
    ApplicationArea eyebrowBrow = ApplicationArea(name: 'eyebrow/brow', id: 9, subOf: FaceArea.EYES, priority: 1, code: 5694);
    faceApplicationMap[FaceArea.EYES] = [
      eyelid,
      eyeSocket,
      orbitalBone,
      eyeliner,
      eyebrowBrow,
    ];

    /// Testing isolate code

    ReceivePort rp = ReceivePort();
    // Isolate worker = await Isolate.spawn(isolatedWorker, rp.sendPort);
    rp.listen(messageHandler);
  }

  void messageHandler(data) async {
    print(data);
    switch (data['name']) {
      case DataName.RECOMMENDEDCOLORS:
        setRecommendedColours(data['data']);
        break;
      case DataName.RECOMMENDEDPRODUCTSFOUNDATION:
        setFoundation(data['data'], data['index']);
        break;
      case DataName.RECOMMENDEDPRODUCTSCONTOUR:
        setContour(data['data'], data['index']);
        break;
      case DataName.RECOMMENDEDPRODUCTSHIGHLIGHTER:
        setHighlighter(data['data'], data['index']);
        break;
      case DataName.RECOMMENDEDPRODUCTSBLUSHER:
        setBlusher(data['data'], data['index']);
        break;
      case DataName.RECOMMENDEDPRODUCTSEYELID:
        setEyelid(data['data'], data['index']);
        break;
      case DataName.RECOMMENDEDPRODUCTSEYESOCKET:
        setEyesocket(data['data'], data['index']);
        break;
      case DataName.RECOMMENDEDPRODUCTSORBITALBONE:
        setOrbitalbone(data['data'], data['index']);
        break;
      case DataName.RECOMMENDEDPRODUCTSEYELINER:
        setEyeliner(data['data'], data['index']);
        break;
      case DataName.RECOMMENDEDPRODUCTSEYEBROW:
        setEyebrow(data['data'], data['index']);
        break;
      case DataName.RECOMMENDEDPRODUCTSLINERSANDPENCILS:
        setLinersandpencils(data['data'], data['index']);
        break;
      case DataName.RECOMMENDEDPRODUCTSLIPSTICK:
        setLipstick(data['data'], data['index']);
        break;
      case DataName.RECOMMENDEDPRODUCTSCONCEALER:
        setConcealer(data['data'], data['index']);
        break;
    }
  }

  void setFoundation(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.CHEEKS][0];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  void setContour(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.CHEEKS][1];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  void setHighlighter(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.CHEEKS][2];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  void setBlusher(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.CHEEKS][3];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  void setEyelid(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.EYES][0];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  void setEyesocket(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.EYES][1];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  void setOrbitalbone(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.EYES][2];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  void setEyeliner(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.EYES][3];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  void setEyebrow(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.EYES][4];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  void setLinersandpencils(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.LIPS][1];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  void setLipstick(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.LIPS][0];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  void setConcealer(products, key) {
    ApplicationArea a = faceApplicationMap[FaceArea.CHEEKS][4];
    a.ready = true;
    a.products[key] = products;

    productMap[a.code] = a.products[key];
    a.extractColours();
    a.extractBrands();
    centralColorMap[a.code] = a.recommendedColors[0];
  }

  Map faceApplicationMap = {
    FaceArea.LIPS: [],
    FaceArea.CHEEKS: [],
    FaceArea.EYES: [],
  };
}

class ApplicationArea {
  late bool ready = false;
  late String name;
  late int id;
  late FaceArea subOf;
  late int priority;
  late int code;
  late int index;
  late Map products = {};
  late Map colors = {};
  late List recommendedColors = [];
  late List brands = [];
  ApplicationArea({
    required this.name,
    required this.id,
    required this.subOf,
    required this.priority,
    required this.code,
  });

  void extractBrands() {
    print('extracting');
  }

  void extractColours() {
    colors.clear();
    products.forEach(
      (key, value) {
        if (value.isEmpty) {
          return;
        }
        List c = [];
        value.forEach(
          (item) {
            item['custom_attributes'].forEach(
              (attr) {
                if (attr.containsKey('attribute_code')) {
                  if (attr['attribute_code'] == 'face_color') {
                    String colorString = attr['value'];
                    final buffer = StringBuffer();
                    if (colorString.length == 6 || colorString.length == 7) buffer.write('ff');
                    buffer.write(colorString.replaceFirst('#', ''));
                    // colors.add(Color(int.parse(buffer.toString(), radix: 16)));
                    c.add(Color(int.parse(buffer.toString(), radix: 16)));
                    // (colors[key] as List).add(Color(int.parse(buffer.toString(), radix: 16)));
                  }
                }
              },
            );
          },
        );
        colors[key] = c;
      },
    );
  }
}

enum FaceArea {
  LIPS,
  CHEEKS,
  EYES,
}

enum DataName {
  RECOMMENDEDCOLORS,
  RECOMMENDEDPRODUCTSFOUNDATION,
  RECOMMENDEDPRODUCTSCONTOUR,
  RECOMMENDEDPRODUCTSHIGHLIGHTER,
  RECOMMENDEDPRODUCTSBLUSHER,
  RECOMMENDEDPRODUCTSEYELID,
  RECOMMENDEDPRODUCTSEYESOCKET,
  RECOMMENDEDPRODUCTSORBITALBONE,
  RECOMMENDEDPRODUCTSEYELINER,
  RECOMMENDEDPRODUCTSEYEBROW,
  RECOMMENDEDPRODUCTSLINERSANDPENCILS,
  RECOMMENDEDPRODUCTSLIPSTICK,
  RECOMMENDEDPRODUCTSCONCEALER,
}

void isolatedWorker(SendPort sp) async {
  // Fetch Recommended Colors and send
  Map resultRecommendedColors = await sfAPIGetRecommendedColours();
  sp.send(
    {
      'data': resultRecommendedColors,
      'name': DataName.RECOMMENDEDCOLORS,
    },
  );

  List recommendedColors = resultRecommendedColors['values']['colors']; // Used to fetch all central colour products

  // Fetch Recommended products for first central colour of foundation
  recommendedColors[0]['color'].forEach(
    (c) async {
      List resultRecommendedProductsFoundation = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5685');
      sp.send(
        {
          'data': resultRecommendedProductsFoundation,
          'name': DataName.RECOMMENDEDPRODUCTSFOUNDATION,
          'index': c,
        },
      );
    },
  );

  // Fetch Recommended products for first central colour of Contour
  recommendedColors[1]['color'].forEach(
    (c) async {
      List resultRecommendedProductsContour = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5686');
      sp.send(
        {
          'data': resultRecommendedProductsContour,
          'name': DataName.RECOMMENDEDPRODUCTSCONTOUR,
          'index': c,
        },
      );
    },
  );

  // Fetch Recommended products for first central colour of Highlighter
  recommendedColors[2]['color'].forEach(
    (c) async {
      List resultRecommendedProductsHighlighter = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5687');
      sp.send(
        {
          'data': resultRecommendedProductsHighlighter,
          'name': DataName.RECOMMENDEDPRODUCTSHIGHLIGHTER,
          'index': c,
        },
      );
    },
  );

  // Fetch Recommended products for first central colour of Blusher
  recommendedColors[3]['color'].forEach(
    (c) async {
      List resultRecommendedProductsBlusher = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5686');
      sp.send(
        {
          'data': resultRecommendedProductsBlusher,
          'name': DataName.RECOMMENDEDPRODUCTSBLUSHER,
          'index': c,
        },
      );
    },
  );

  // Fetch Recommended products for first central colour of Eyelid
  recommendedColors[4]['color'].forEach(
    (c) async {
      List resultRecommendedProductsEyelid = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5681', '5690');
      sp.send(
        {
          'data': resultRecommendedProductsEyelid,
          'name': DataName.RECOMMENDEDPRODUCTSEYELID,
          'index': c,
        },
      );
    },
  );

  // Fetch Recommended products for first central colour of Eyesocket
  recommendedColors[5]['color'].forEach(
    (c) async {
      List resultRecommendedProductsEyeSocket = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5691');
      sp.send(
        {
          'data': resultRecommendedProductsEyeSocket,
          'name': DataName.RECOMMENDEDPRODUCTSEYESOCKET,
          'index': c,
        },
      );
    },
  );

  // Fetch Recommended products for first central colour of Orbitalbone
  recommendedColors[6]['color'].forEach(
    (c) async {
      List resultRecommendedProductsOrbitalbone = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5692');
      sp.send(
        {
          'data': resultRecommendedProductsOrbitalbone,
          'name': DataName.RECOMMENDEDPRODUCTSORBITALBONE,
          'index': c,
        },
      );
    },
  );

  // Fetch Recommended products for first central colour of Eyeliner
  recommendedColors[7]['color'].add(['#ff0000', 'main']);
  recommendedColors[7]['color'].forEach(
    (c) async {
      List resultRecommendedProductsEyeliner = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5693');
      sp.send(
        {
          'data': resultRecommendedProductsEyeliner,
          'name': DataName.RECOMMENDEDPRODUCTSEYELINER,
          'index': c,
        },
      );
    },
  );

  // Fetch Recommended products for first central colour of Eyebrow
  recommendedColors[8]['color'].forEach(
    (c) async {
      List resultRecommendedProductsEyebrow = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5694');
      sp.send(
        {
          'data': resultRecommendedProductsEyebrow,
          'name': DataName.RECOMMENDEDPRODUCTSEYEBROW,
          'index': c,
        },
      );
    },
  );

  // Fetch Recommended products for first central colour of Linersandpencils
  recommendedColors[9]['color'].forEach(
    (c) async {
      List resultRecommendedProductsLinersandpencils = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5696');
      sp.send(
        {
          'data': resultRecommendedProductsLinersandpencils,
          'name': DataName.RECOMMENDEDPRODUCTSLINERSANDPENCILS,
          'index': c,
        },
      );
    },
  );

  // Fetch Recommended products for first central colour of Lipstick
  recommendedColors[10]['color'].forEach(
    (c) async {
      List resultRecommendedProductsLipstick = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5697');
      sp.send(
        {
          'data': resultRecommendedProductsLipstick,
          'name': DataName.RECOMMENDEDPRODUCTSLIPSTICK,
          'index': c,
        },
      );
    },
  );

  // Fetch Recommended products for first central colour of Concealer
  recommendedColors[11]['color'].forEach(
    (c) async {
      List resultRecommendedProductsConcealer = await sfAPIGetRecommendedProductsByApplicationArea('${c[0]}', '5682', '5689');
      sp.send(
        {
          'data': resultRecommendedProductsConcealer,
          'name': DataName.RECOMMENDEDPRODUCTSCONCEALER,
          'index': c,
        },
      );
    },
  );
}
